local Balls = require("balls")

local plenary = Balls:register("git@github.com:nvim-lua/plenary.nvim.git", {
	name = "plenary"
})

Balls:register("git@github.com:nvim-telescope/telescope.nvim.git", {
name = "telescope"
})

local ok, telescope = pcall(require, "telescope")

if not (ok and plenary:installed()) then
	return
end

telescope.setup({})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>n", builtin.find_files)
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader><leader>", builtin.buffers)
vim.keymap.set("n", "<leader>sf", builtin.lsp_document_symbols)
vim.keymap.set("n", "<leader>sm", builtin.marks)
vim.keymap.set("n", "<leader>sr", builtin.resume)

