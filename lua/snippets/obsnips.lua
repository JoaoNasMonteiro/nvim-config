local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local date_today = function()
	return { os.date("%Y-%m-%d") }
end

ls.add_snippets("markdown", {

	s("!task", {
		t("- [ ] "),
		i(1, "Descrição da tarefa"),
		t(" 📅 "),
		i(2, os.date("%Y-%m-%d")),
	}),

	s("!due", {
		t("📅 "),
		i(1, os.date("%Y-%m-%d")),
	}),

	s("!start", {
		t("⏳ "),
		i(1, os.date("%Y-%m-%d")),
	}),

	s("!done", {
		t("✅ "),
		f(date_today, {}),
	}),
})
