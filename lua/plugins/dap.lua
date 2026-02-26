return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Interface gráfica do debugger
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    
    -- Integração com o Mason para baixar os debuggers
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    
    -- Configuração facilitada para Python
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- 1. Configuramos o Mason para gerenciar os debuggers
    require("mason-nvim-dap").setup({
      ensure_installed = {
        "codelldb", -- Excelente debugger padrão da indústria para C/C++
        "python",   -- Instala o pacote 'debugpy'
      },
      -- O handler vazio faz o plugin configurar o codelldb automaticamente
      handlers = {}, 
    })

    -- 2. Iniciamos a Interface Gráfica
    dapui.setup()

    -- Eventos para abrir a UI quando o debug começar e fechar quando terminar
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- 3. Configuração específica para Python
    -- Apontamos para o executável do Python dentro da pasta do Mason
    local mason_path = vim.fn.stdpath("data") .. "/mason/"
    require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")

    -- 4. Mapeamento de Teclas Clássicos
    -- Espaço + b: Coloca/Remove um ponto de parada (Breakpoint)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Alternar Breakpoint' })
    
    -- F5: Inicia ou continua a execução
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Iniciar/Continuar' })
    
    -- F10: Pula para a próxima linha (Step Over)
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Pular Linha' })
    
    -- F11: Entra dentro da função (Step Into)
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Entrar na Função' })
    
    -- F12: Sai da função atual (Step Out)
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Sair da Função' })
  end,
}
