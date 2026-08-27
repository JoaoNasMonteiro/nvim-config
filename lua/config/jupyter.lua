-- lua/config/jupyter.lua
-- Gerenciamento de sincronização bidirecional de Notebooks (.ipynb <-> .py) via Jupytext

local jupytext_group = vim.api.nvim_create_augroup("JupytextIntegration", { clear = true })

-- Intercepta a ABERTURA do arquivo .ipynb
vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = "*.ipynb",
    group = jupytext_group,
    desc = "Lê o JSON do ipynb e converte para texto Python em memória",
    callback = function(opts)
        local filepath = vim.fn.expand("<afile>")
        local cmd = string.format("jupytext --to py:percent --output - '%s'", filepath)
        local output = vim.fn.systemlist(cmd)
        
        if vim.v.shell_error ~= 0 then
            vim.notify("Erro ao ler ipynb via Jupytext", vim.log.levels.ERROR)
            return
        end

        vim.api.nvim_buf_set_lines(opts.buf, 0, -1, false, output)
        vim.bo[opts.buf].filetype = "python"
        vim.bo[opts.buf].modified = false
    end,
})

-- Intercepta o SALVAMENTO do arquivo .ipynb
vim.api.nvim_create_autocmd("BufWriteCmd", {
    pattern = "*.ipynb",
    group = jupytext_group,
    desc = "Lê o texto Python da tela e atualiza o JSON do ipynb no disco",
    callback = function(opts)
        local filepath = vim.api.nvim_buf_get_name(opts.buf)
        local lines = vim.api.nvim_buf_get_lines(opts.buf, 0, -1, false)

        local cmd = string.format("jupytext --from py:percent --to ipynb --output '%s' -", filepath)
        local result = vim.fn.system(cmd, lines)

        if vim.v.shell_error == 0 then
            vim.bo[opts.buf].modified = false
            vim.notify("Notebook sincronizado com sucesso!", vim.log.levels.INFO, { title = "Jupyter" })
        else
            vim.notify("Erro ao salvar: " .. tostring(result), vim.log.levels.ERROR, { title = "Jupyter" })
        end
    end,
})
