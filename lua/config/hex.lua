-- Removemos a dependência do plugin e centralizamos a lógica nativa
local hex_group = vim.api.nvim_create_augroup("BinaryWorkflow", { clear = true })

-- Define as colunas iniciais globais
vim.g.current_hex_cols = 16

-- Função centralizada para renderizar hex e restaurar o estado do buffer
local function render_hex_view()
    local save_cursor = vim.fn.getpos(".")
    -- -g 2 (agrupa 2 bytes), -u (uppercase), -c N (colunas)
    local cmd = string.format("silent %%!xxd -g 2 -u -c %d", vim.g.current_hex_cols)
    vim.cmd(cmd)
    
    vim.bo.filetype = "xxd"
    -- A conversão altera o buffer. Precisamos dizer ao Neovim que o arquivo
    -- não tem edições pendentes logo após a conversão inicial ou pós-salvamento.
    vim.bo.modified = false 
    vim.fn.setpos(".", save_cursor)
end

-- 1. ANTES DE LER: Prepara o Neovim para tratar o arquivo como binário puro
vim.api.nvim_create_autocmd({"BufReadPre", "BufNewFile"}, {
    group = hex_group,
    pattern = { "*.ch8", "*.out", "*.bin", "*.rom", "*.iso", "*.dump" },
    callback = function()
        vim.bo.binary = true
        -- Fundamental: evita que o Neovim tente converter quebras de linha (CRLF),
        -- o que corromperia arquivos binários silenciosamente.
        vim.bo.fileformat = "unix" 
    end,
})

-- 2. DEPOIS DE LER: Converte o blob binário para visualização Hex (O que faltava na sua config)
vim.api.nvim_create_autocmd("BufReadPost", {
    group = hex_group,
    pattern = { "*.ch8", "*.out", "*.bin", "*.rom", "*.iso", "*.dump" },
    callback = function()
        if vim.bo.binary then
            render_hex_view()
        end
    end,
})

-- 3. ANTES DE SALVAR: Reverte de Hex para Binário para gravação no disco
vim.api.nvim_create_autocmd("BufWritePre", {
    group = hex_group,
    pattern = "*", -- Aplica a qualquer arquivo, contanto que seja bo.binary
    callback = function()
        if vim.bo.binary then
            local save_cursor = vim.fn.getpos(".")
            local cmd = string.format("silent %%!xxd -r -c %d", vim.g.current_hex_cols)
            vim.cmd(cmd)
            vim.fn.setpos(".", save_cursor)
        end
    end,
})

-- 4. DEPOIS DE SALVAR: Retorna para a visualização Hex após a gravação
vim.api.nvim_create_autocmd("BufWritePost", {
    group = hex_group,
    pattern = "*",
    callback = function()
        if vim.bo.binary then
            render_hex_view()
        end
    end,
})

-- Funções para redimensionamento dinâmico
_G.DecreaseHexColumns = function()
    if not vim.bo.binary then return end
    if vim.g.current_hex_cols > 2 then
        -- REQUISITO: Reverter o painel atual para binário antes de re-formatar
        vim.cmd(string.format("silent %%!xxd -r -c %d", vim.g.current_hex_cols))
        
        vim.g.current_hex_cols = vim.g.current_hex_cols / 2
        render_hex_view()
        print("Hex Columns: " .. vim.g.current_hex_cols)
    else
        print("Limite mínimo atingido (2 colunas)")
    end
end

_G.IncreaseHexColumns = function()
    if not vim.bo.binary then return end
    if vim.g.current_hex_cols < 64 then
        -- REQUISITO: Reverter o painel atual para binário antes de re-formatar
        vim.cmd(string.format("silent %%!xxd -r -c %d", vim.g.current_hex_cols))
        
        vim.g.current_hex_cols = vim.g.current_hex_cols * 2
        render_hex_view()
        print("Hex Columns: " .. vim.g.current_hex_cols)
    else
        print("Limite máximo atingido (64 colunas)")
    end
end

-- Keymaps nativos (Sem dependência de plugin)
vim.keymap.set("n", "<leader>xn", "<cmd>lua DecreaseHexColumns()<cr>", { desc = "Decrease Hex Columns (2^x)" })
vim.keymap.set("n", "<leader>xm", "<cmd>lua IncreaseHexColumns()<cr>", { desc = "Increase Hex Columns (2^x)" })
