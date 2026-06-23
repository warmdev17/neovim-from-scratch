local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {

	-- =========================
	-- ABC
	-- =========================
	s("abc", {
		t("from abc import ABC, abstractmethod"),
		t({ "", "", "class " }),
		i(1, "MyClass"),
		t("(ABC):"),
		t({ "", "", "\t@abstractmethod", "\tdef " }),
		i(2, "method"),
		t("(self"),
		i(3),
		t(") -> "),
		i(4, "None"),
		t(":"),
		t({ "", "\t\t" }),
		i(5, "pass"),
	}),

	-- =========================
	-- INIT
	-- =========================
	s("init", {
		t("def __init__(self"),
		i(1),
		t("):"),
		t({ "", "\t" }),
		i(2, "pass"),
	}),

	-- =========================
	-- CLASS
	-- =========================
	s("class", {
		t("class "),
		i(1, "MyClass"),
		t(":"),
		t({ "", "\tdef __init__(self):", "\t\tpass" }),
	}),

	-- =========================
	-- MAGIC METHODS
	-- =========================
	s("str", {
		t("def __str__(self):"),
		t({ "", "\treturn " }),
		i(1, '""'),
	}),

	-- =========================
	-- PROPERTY
	-- =========================
	s("prop", {
		t("@property"),
		t({ "", "def " }),
		i(1, "name"),
		t("(self):"),
		t({ "", "\treturn self.__" }),
		rep(1),
	}),

	s("setter", {
		t("@"),
		i(1, "name"),
		t(".setter"),
		t({ "", "def " }),
		rep(1),
		t("(self, new_"),
		rep(1),
		t("):"),
		t({ "", "\tself.__" }),
		rep(1),
		t(" = new_"),
		rep(1),
	}),

	-- =========================
	-- CLASSMETHOD / STATIC
	-- =========================
	s("cm", {
		t("@classmethod"),
		t({ "", "def from_" }),
		i(1, "data"),
		t("(cls, "),
		i(2, "value"),
		t("):"),
		t({ "", "\treturn cls(" }),
		i(3),
		t(")"),
	}),

	s("sm", {
		t("@staticmethod"),
		t({ "", "def " }),
		i(1, "func"),
		t("("),
		i(2),
		t("):"),
		t({ "", "\t" }),
		i(3, "pass"),
	}),

	-- =========================
	-- TEST
	-- =========================
	s("test", {
		t("def test_"),
		i(1, "name"),
		t("():"),
		t({ "", "\tassert " }),
		i(2),
		t(" == "),
		i(3),
	}),

	-- =========================
	-- DEBUG
	-- =========================
	s("pp", {
		t('print(f"'),
		i(1, "var"),
		t(" = {"),
		rep(1),
		t('}")'),
	}),

	-- print format string
	s("pf", {
		t('print(f"'),
		i(1),
		t('")'),
	}),

	-- =========================
	-- MAIN
	-- =========================
	s("main", {
		t({ 'if __name__ == "__main__":', "\t" }),
		i(1, "main()"),
	}),
}
