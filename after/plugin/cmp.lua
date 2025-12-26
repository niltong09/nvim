local Balls = require("balls")

local snips = Balls:register("git@github.com:L3MON4D3/LuaSnip.git", {
	name = "luasnip",
})

local friendlysnippets = Balls:register("git@github.com:rafamadriz/friendly-snippets.git", {
	name = "friendlysnippets",
})

local buffer = Balls:register("git@github.com:hrsh7th/cmp-buffer.git")
local path = Balls:register("git@github.com:hrsh7th/cmp-path.git")
local cmdline = Balls:register("git@github.com:hrsh7th/cmp-cmdline.git")
local lsp = Balls:register("git@github.com:hrsh7th/cmp-nvim-lsp.git")

Balls:register("git@github.com:hrsh7th/nvim-cmp.git", {
	name = "cmp",
})

local ok, cmp = pcall(require,"cmp")

if not (ok and snips:installed() and friendlysnippets:installed() and buffer:installed() and path:installed() and cmdline:installed() and lsp:installed()) then
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args)
		end,
	},
	mapping = {
		['<C-space'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<down>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<up>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
		['<C-y>'] = cmp.mapping.confirm({ select = true })
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" }
	})
})

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip").filetype_extend("typescript", { "javascript" })

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })


-- vim.lsp.config('ts_ls', {
--     capabilities = capabilities,
-- })

-- vim.lsp.config('vue_ls', {
--     capabilities = capabilities,
-- })

