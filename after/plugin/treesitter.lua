local Balls = require("balls")

Balls:register("git@github.com:nvim-treesitter/nvim-treesitter.git", {
	name = "treesitter",
})

local ok, ts = pcall(require, "treesitter")

if not ok then
	return
end

ts.setup({})

