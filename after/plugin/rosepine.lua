local Balls = require("balls")

Balls:register("git@github.com:rose-pine/neovim.git", {
	name = "rosepine"
})

local ok, rosepine = pcall(require, "rose-pine")

if not ok then
	vim.notify("rose pine not found")
	return
end

rosepine.setup({})

vim.cmd("colorscheme rose-pine")

