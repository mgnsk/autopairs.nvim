local utils = require("tests.test_utils")

local data = {
	{
		name = "pair",
		before = [[|]],
		feed = [[a<]],
		after = { [[<|>]] },
	},
	{
		name = "nested pair",
		before = [[<|>]],
		feed = [[a<]],
		after = { [[<<|>>]] },
	},
	{
		name = "no pair when manually closing",
		before = [[<|>]],
		feed = [[a>]],
		after = { [[<>|]] },
	},
	{
		name = "no pair when existing brace on right",
		before = [[|>]],
		feed = [[i<]],
		after = { [[<|>]] },
	},
	{
		name = "enter between braces",
		before = [[<|>]],
		feed = [[a<CR>]],
		after = {
			[[<]],
			[[|]], -- Note: depends on autoindent.
			[[>]],
		},
	},
	{
		name = "backspace between braces",
		before = [[<|>]],
		feed = [[a<BS>]],
		after = { "|" },
	},
	{
		name = "backspace between nested braces",
		before = [[<<|>>]],
		feed = [[a<BS>]],
		after = { "<|>" },
	},
}

describe("quotes", function()
	before_each(function()
		require("dumb-autopairs").setup({
			pairs = {
				{
					left = "<",
					right = ">",
				},
			},
		})
	end)

	for _, tc in ipairs(data) do
		utils.run_test(tc)
	end
end)
