local ok, cmp = pcall(require, "blink.cmp")

if not ok then
    return
end

cmp.setup({
    keymap = {
        preset = 'default',
        -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_notification' },
        -- ['<C-g>'] = { 'show', 'show_documentation', 'hide_notification' },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
})

local Balls = require("balls")

Balls:register("git@github.com:L3MON4D3/LuaSnip.git", {
	name = "luasnip",
    rev = "v2.4.1",
    on_sync = function()
        local command = {
            'make',
            'install_jsregexp',
        }
        vim.system.command(command, {}, vim.schedule_wrap(function(result)
            if result.code ~= 0 then
                error("LuaSnip build errored" .. vim.trim(result.stderr))
            end
            vim.notify("LuaSnip jsregexp installed")
        end
    ))
    end,
})
Balls:register("git@github.com:rafamadriz/friendly-snippets.git", {
	name = "friendlysnippets",
})
require("luasnip.loaders.from_vscode").lazy_load()
--
-- local buffer = Balls:register("git@github.com:hrsh7th/cmp-buffer.git")
-- local path = Balls:register("git@github.com:hrsh7th/cmp-path.git")
-- local cmdline = Balls:register("git@github.com:hrsh7th/cmp-cmdline.git")
-- local lsp = Balls:register("git@github.com:hrsh7th/cmp-nvim-lsp.git")
-- local luasnip = Balls:register("git@github.com:saadparwaiz1/cmp_luasnip.git")
--
-- Balls:register("git@github.com:hrsh7th/nvim-cmp.git", {
-- 	name = "cmp",
-- })
--
-- local ok, cmp = pcall(require,"cmp")
--
-- if not (ok and snips:installed() and friendlysnippets:installed() and buffer:installed() and path:installed() and cmdline:installed() and lsp:installed() and luasnip:installed()) then
--     vim.notify("cmp not loaded")
-- 	return
-- end
--
-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			require("luasnip").lsp_expand(args)
-- 		end,
-- 	},
-- 	mapping = {
-- 		['<C-space'] = cmp.mapping.complete(),
-- 		['<C-e>'] = cmp.mapping.abort(),
-- 		['<down>'] = function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_next_item()
-- 			else
-- 				fallback()
-- 			end
-- 		end,
-- 		['<up>'] = function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_prev_item()
-- 			else
-- 				fallback()
-- 			end
-- 		end,
-- 		['<C-y>'] = cmp.mapping.confirm({ select = true })
-- 	},
-- 	sources = cmp.config.sources({
-- 		{ name = "nvim_lsp" },
-- 		{ name = "luasnip" },
-- 	}, {
-- 		{ name = "buffer" }
-- 	})
-- })
--
--
-- require("luasnip").filetype_extend("typescript", { "javascript" })
--
-- cmp.setup.cmdline({ '/', '?' }, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--       { name = 'buffer' }
--     }
--   })
--
-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--       { name = 'path' }
--     }, {
--       { name = 'cmdline' }
--     }),
--     matching = { disallow_symbol_nonprefix_matching = false }
--   })
--
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
-- vim.lsp.config('phpactor', {
--     capabilities = capabilities,
-- })
-- vim.lsp.config('lua_ls', {
--     capabilities = capabilities,
-- })
-- vim.notify("enabled cmp capabilities")
--
-- -- vim.lsp.config('ts_ls', {
-- --     capabilities = capabilities,
-- -- })
--
-- -- vim.lsp.config('vue_ls', {
-- --     capabilities = capabilities,
-- -- })
--
