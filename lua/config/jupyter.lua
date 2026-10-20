-- lua/config/jupyter.lua
-- Gerenciamento nativo de arquivos .ipynb via Jupytext CLI (BufReadCmd / BufWriteCmd)

local jupytext_group = vim.api.nvim_create_augroup("CustomJupytext", { clear = true })

local EMPTY_IPYNB = [[
{
 "cells": [],
 "metadata": {},
 "nbformat": 4,
 "nbformat_minor": 5
}
]]

-- 1. INTERCEPTA A LEITURA (BufReadCmd)
vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = "*.ipynb",
    group = jupytext_group,
    desc = "Carrega .ipynb como script Python (percent format) na memória",
    callback = function(args)
        local buf = args.buf
        local filepath = vim.fn.fnamemodify(args.file, ":p")

        vim.bo[buf].buftype = ""
        vim.bo[buf].swapfile = false

        local lines = {}

        if vim.fn.filereadable(filepath) == 1 and vim.fn.getfsize(filepath) > 0 then
            local res = vim.system({
                "jupytext",
                "--from", "ipynb",
                "--to", "py:percent",
                "--output", "-",
                filepath,
            }, { text = true }):wait()

            if res.code ~= 0 then
                vim.notify(
                    "Erro no Jupytext ao ler arquivo:\n" .. (res.stderr or "Erro desconhecido"),
                    vim.log.levels.ERROR,
                    { title = "Jupytext" }
                )
                return
            end

            lines = vim.split(res.stdout or "", "\n", { plain = true })
            if lines[#lines] == "" then
                table.remove(lines, #lines)
            end
        else
            lines = { "# %%" }
        end

        local ul = vim.bo[buf].undolevels
        vim.bo[buf].undolevels = -1
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].undolevels = ul

        vim.bo[buf].filetype = "python"
        vim.bo[buf].modified = false

        vim.api.nvim_exec_autocmds("BufReadPost", { buffer = buf })
    end,
})

-- 2. INTERCEPTA QUALQUER SALVAMENTO (:w, :wq, :x, ZZ)
vim.api.nvim_create_autocmd("BufWriteCmd", {
    pattern = "*.ipynb",
    group = jupytext_group,
    desc = "Converte o buffer Python de volta para JSON .ipynb no disco preservando outputs",
    callback = function(args)
        local buf = args.buf
        -- Usa o nome do arquivo passado pelo comando de escrita (suporta :w outro_nome.ipynb)
        local filepath = vim.fn.fnamemodify(args.file, ":p")
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

        -- Se o arquivo .ipynb ainda não existir no disco, cria o esqueleto JSON
        if vim.fn.filereadable(filepath) == 0 or vim.fn.getfsize(filepath) == 0 then
            vim.fn.writefile(vim.split(EMPTY_IPYNB, "\n", { plain = true }), filepath)
        end

        -- Cria um arquivo temporário com extensão .py explícita para evitar o bug de
        -- detecção de extensão '.' do jupytext ao usar '--update' com stdin ('-')
        local tmp_py = vim.fn.tempname() .. ".py"
        vim.fn.writefile(lines, tmp_py)

        local res = vim.system({
            "jupytext",
            "--from", "py:percent",
            "--to", "ipynb",
            "--update",
            "--output", filepath,
            tmp_py,
        }, { text = true }):wait()

        -- Limpa o arquivo temporário imediatamente
        os.remove(tmp_py)

        if res.code == 0 then
            vim.bo[buf].modified = false
            vim.cmd("silent! checktime")
            vim.api.nvim_exec_autocmds("BufWritePost", { buffer = buf })
            vim.notify("Notebook sincronizado com sucesso!", vim.log.levels.INFO, { title = "Jupyter" })
        else
            vim.notify(
                "Erro ao salvar .ipynb:\n" .. (res.stderr or "Erro desconhecido"),
                vim.log.levels.ERROR,
                { title = "Jupytext" }
            )
        end
    end,
})
