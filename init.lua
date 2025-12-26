local config_path = vim.fn.stdpath("config")
local balls_path = vim.fs.joinpath(config_path, "pack", "balls", "start", "balls.nvim")

if not vim.uv.fs_stat(balls_path) then
  local command = {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/TheBallsUp/balls.nvim",
    balls_path,
  }

  vim.system(command, {}, vim.schedule_wrap(function(result)
    if result.code ~= 0 then
      error("Falha ao instalar balls.nvim: " .. vim.trim(result.stderr))
    end

    vim.notify("Balls.nvim instalado com sucesso!")
  end))
end

local ok, Balls = pcall(require, "balls")

if not ok then
  return
end

Balls:setup({
  -- Instala automaticamente plugins registrados
  auto_install = true,
})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  leadmultispace = '│   ',
}

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', ']q', ':cn<CR>', { desc = 'Go to next [Q]uickfix message' })
vim.keymap.set('n', '[q', ':cp<CR>', { desc = 'Go to prev [Q]uickfix message' })
vim.keymap.set('i', '<C-BS>', 'dvbi', { desc = 'Delete previous word', silent = true })
vim.keymap.set('n', '<leader>rr', ':e ~/scratch<CR>', { desc = 'Reach Scratch' })
-- vim.keymap.set('x', 'p', '"_dp', { desc = 'Paste from register', noremap = true, silent = true })
-- vim.keymap.set('x', 'P', '"_dP', { desc = 'Paste from register', noremap = true, silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down', noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up', noremap = true, silent = true })

-- vim.keymap.set({ 'n', 'v' }, 'm', 'h', { desc = 'Move cursor left', noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'v' }, 'n', 'j', { desc = 'Move cursor down', noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'v' }, 'e', 'k', { desc = 'Move cursor up', noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'v' }, 'i', 'l', { desc = 'Move cursor right', noremap = true, silent = true })
-- vim.keymap.set('n', 'h', 'i', { desc = 'enter insert mode', noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'v' }, 'l', 'e', { desc = 'end of word', noremap = true, silent = true })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'next found', noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'prev found', noremap = true, silent = true })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'paste with no replace', noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'yank to register', noremap = true, silent = true })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'yank line', noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'del to void', noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- TODO  Ajustar para suportar o focus do tmux

-- [[ My Settings ]]
vim.opt.wildignore:append '*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*'
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<C-d>', '<C-d>zz')
vim.keymap.set('v', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- map control c to esc
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<C-s>', ':up<CR>')
vim.keymap.set('n', '<C-q>', ':q<CR>')

function open_netrw_cfd()
  local fn = vim.api.nvim_buf_get_name(0)
  if fn == nil or fn == '' then
    vim.cmd([[ Explore ]] .. '.')
  else
    local fph = fn:match '(.*/)'
    vim.cmd([[ Explore ]] .. fph)
  end
end

function chmod_exec()
  local fn = vim.api.nvim_buf_get_name(0)
  if fn == nil or fn == '' then
    return
  end
  vim.fn.system('chmod +x ' .. fn)
end

function apply_env()
  vim.fn.system '/home/gabriel/Projetos/pessoal/devenv/apply_env'
end

vim.keymap.set('n', '<leader>j', open_netrw_cfd)
vim.keymap.set('n', '<leader>x', chmod_exec)
vim.keymap.set('n', '<leader>,', apply_env)
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.colorcolumn = '80'

vim.keymap.set('n','<leader>e',':G<CR>')

vim.keymap.set('n', '<leader>ss', ':G pull --rebase<CR>:G push')

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Open netrw on nvim load',
  callback = function()
    local fn = vim.api.nvim_buf_get_name(0)
    if fn == nil or fn == '' then
      vim.cmd([[ Explore ]] .. '.')
    end
  end,
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local save_fold = augroup('Persistent Folds', { clear = true })

autocmd('BufWinLeave', {
  pattern = '*.*',
  callback = function()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local file_exists = vim.fn.filereadable(buffer_name)
    if file_exists == 1 then
      vim.cmd.mkview()
    end
  end,
  group = save_fold,
})

autocmd('BufWinEnter', {
  pattern = '*.*',
  callback = function()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local file_exists = vim.fn.filereadable(buffer_name)
    if file_exists == 1 then
      vim.cmd.loadview { mods = { emsg_silent = true } }
    end
  end,
  group = save_fold,
})
