return {
  "L3MON4D3/LuaSnip",
  -- MELHOR PRÁTICA: Compila a biblioteca C jsregexp silenciosamente durante a instalação.
  -- Isso resolve o aviso do :checkhealth e permite transformações avançadas de regex.
  build = "make install_jsregexp",
  dependencies = {
    -- Banco de dados global com milhares de snippets prontos para várias linguagens
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local ls = require("luasnip")

    -- Instrui o LuaSnip a carregar os snippets do friendly-snippets (formato VS Code)
    require("luasnip.loaders.from_vscode").lazy_load()

    require("luasnip.loaders.from_lua").load({
      paths = { vim.fn.stdpath("config") .. "/snippets" }
    })
    -- Configuração do comportamento do motor
    ls.config.set_config({
      history = true, -- Mantém o último snippet na memória para você poder voltar a ele
      update_events = "TextChanged,TextChangedI", -- Atualiza referências dinâmicas enquanto você digita
    })
  end,
}

