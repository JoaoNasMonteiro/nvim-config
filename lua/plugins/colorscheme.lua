return {
  "srcery-colors/srcery-vim",
  lazy = false,
  priority = 1000,

  config = function()
    vim.g.srcery_italic = 1

    -- MELHOR PRÁTICA: Intercepta o carregamento do tema "srcery" e aplica
    -- as nossas regras customizadas por cima dele de forma permanente.
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "srcery",
      callback = function()
        -- Paleta Hexadecimal Oficial do Srcery
        local srcery_bright_red = "#F75341"
        local srcery_red = "#EF2F27"
        local srcery_bright_orange = "#FF8700"
        local srcery_orange = "#FF5F00"
        local srcery_yellow = "#FBB829"
        local srcery_bright_yellow = "#FED06E"
        local srcery_bright_black = "#2D2C29" -- Cor de fundo suave

        -- 1. Regras do Treesitter (O motor sintático principal)
        vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = srcery_red, bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = srcery_orange, bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = srcery_yellow, bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = srcery_bright_yellow, bold = true })

        -- 2. Regras de Fallback (Caso o Treesitter falhe ou atrase)
        vim.api.nvim_set_hl(0, "markdownH1", { fg = srcery_red, bold = true })
        vim.api.nvim_set_hl(0, "markdownH2", { fg = srcery_orange, bold = true })
        vim.api.nvim_set_hl(0, "markdownH3", { fg = srcery_yellow, bold = true })
        vim.api.nvim_set_hl(0, "markdownH4", { fg = srcery_bright_yellow, bold = true })

        -- 3. Regras para o render-markdown.nvim (Ícones e Fundos)
        vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = srcery_red })
        vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = srcery_orange})
        vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = srcery_yellow })
        vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = srcery_bright_yellow })

        -- 4. Regras para os Blocos de Código (Code Blocks)
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = srcery_bright_black })
        vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = srcery_bright_black })
      end,
    })

    -- Carrega o tema (isso vai engatilhar o autocmd acima automaticamente)
    vim.cmd.colorscheme("srcery")
  end,
}
