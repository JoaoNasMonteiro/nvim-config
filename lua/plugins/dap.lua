return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",

    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = {
        "codelldb",
        "python",
      },
      handlers = {},
    })

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      }
    }

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    local mason_path = vim.fn.stdpath("data") .. "/mason/"
    require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")

    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Alternar Breakpoint' })
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Iniciar/Continuar' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Pular Linha' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Entrar na Função' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Sair da Função' })
  end,
}
