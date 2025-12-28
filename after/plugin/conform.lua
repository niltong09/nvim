local Balls = require("balls")

Balls:register("git@github.com:stevearc/conform.nvim.git", {
	name = "conform",
})

local ok, conform = pcall(require, "conform")

if not ok then
	return
end

conform.setup({
    formatters = {
        phpcbf = {
            prepend_args = { "--standard=PSR12" },
        },
    },
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		go = { "gofmt" },
		templ = { "templ" },
        php = { "phpcbf" },
	},
})

vim.keymap.set("n", "<leader>f", conform.format)
