local Balls = require("balls")

Balls:register("git@github.com:nvim-treesitter/nvim-treesitter.git", {
	name = "treesitter",
})

local ok, ts = pcall(require, "nvim-treesitter")

if not ok then
	return
end

ts.setup({
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'templ', 'go', 'php' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { 'ruby' } },
})
vim.cmd(":TSUpdate<CR><CR>")
ts.install({ 
'bash', 
'c', 
'diff', 
'html', 
'lua', 
'luadoc', 
'markdown', 
'markdown_inline', 
'query', 
'vim', 
'vimdoc', 
'templ', 
'go', 
'php',
'phpdoc',
'javascript',
'typescript',
'json',
})

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { 
    '*.blade.php', 
    '*.php', 
    '*.lua',
    '*.go',
    '*.templ',
    '*.sh',
    '*.html',
    '*.c',
    '*.h',
    '*.cpp',
    '*.md',
    '*.txt',
    '*.js',
    '*.jsx',
    '*.ts',
    '*.tsx',
    '*.json',
    },
    callback = function() 
        vim.treesitter.start() 
    end,
})

-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = { 'blade' },
--     callback = function() vim.treesitter.start() end,
-- })
      -- -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      -- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      -- parser_config.blade = {
      --   install_info = {
      --     url = 'https://github.com/EmranMR/tree-sitter-blade',
      --     files = { 'src/parser.c' },
      --     branch = 'main',
      --   },
      --   filetype = 'blade',
      -- }

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      -- require('nvim-treesitter.configs').setup(opts)
      -- setup folding
      vim.o.foldenable = false
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'


