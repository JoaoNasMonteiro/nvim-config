return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,

      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },

      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<space>"] = "none",
          ["l"] = "open",
          ["h"] = "close_node",
          ["a"] = {
            "add",
            config = {
              show_path = "none"
            }
          },
          ["d"] = "delete",
          ["r"] = "rename",
        }
      }
    })

    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Alternar Explorador de Arquivos', silent = true })
  end,
}
