
local Balls = require('balls')

local lspconfig = Balls:register("git@github.com:neovim/nvim-lspconfig.git")


if not lspconfig:installed() then
    vim.notify("no lspconfig")
    return
end

-- lspconfig.setup({})
vim.lsp.config('lua_ls', {
    cmd = { 'emmylua_ls' },
    settings = {
        Lua = {
			runtime = {
				version = 'LuaJIT',
			},
            diagnostics = {
                globals = { 'vim' },
            },
        }
    }
})
vim.lsp.config('kotlin', {
	cmd = { 'kotlin-lsp','--stdio' },
	filetypes = { 'kotlin' },
	root_markers = {
        'settings.gradle',
        'settings.gradle.kts',
        'pom.xml',
        'build.gradle',
        'build.gradle.kts',
        'workspace.json',
    },
})
vim.lsp.enable('phpactor')
vim.lsp.enable('ts_ls')
vim.lsp.enable('vue_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('templ')
vim.lsp.enable('lua_ls')
vim.lsp.enable('kotlin')

vim.diagnostic.config({ virtual_text = true })
vim.notify("lsps enabled")



-- vim.api.nvim_create_user_command("LspRestart", 
-- function()
-- vim.lsp.stop_client(vim.lsp.get_clients())
-- vim.cmd.e()
-- end, 
-- {
-- nargs = 0,
-- desc = "Restart lsp"
-- })

