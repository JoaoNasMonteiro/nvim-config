local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Função auxiliar para pegar a data atual no formato YYYY-MM-DD
local date_today = function()
    return {os.date("%Y-%m-%d")}
end

ls.add_snippets("markdown", {

    -- Macro 1: Expande '!task' para uma tarefa completa com espaço para digitar e data de entrega
    s("!task", {
        t("- [ ] "),
        i(1, "Descrição da tarefa"),
        t(" 📅 "),
        i(2, os.date("%Y-%m-%d")), -- Padrão é a data de hoje, mas você pode alterar
    }),

    -- Macro 2: Expande '!due' para inserir apenas o emoji e a data de prazo (ideal para adicionar a tarefas já existentes)
    s("!due", {
        t("📅 "),
        i(1, os.date("%Y-%m-%d")),
    }),

    -- Macro 3: Expande '!start' para inserir a data de início
    s("!start", {
        t("⏳ "),
        i(1, os.date("%Y-%m-%d")),
    }),

    -- Macro 4: Expande '!done' para marcar como concluído com a data de hoje
    s("!done", {
        t("✅ "),
        f(date_today, {}),
    }),
})
