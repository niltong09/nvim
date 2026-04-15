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
vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd('filetype plugin indent on')
vim.g.php_folding = 1
vim.g.PHP_autoformatcomment = 1

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
vim.keymap.set('n', '<C-g>', ':G<CR>')

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

local function run_realtime_float(command)
  -- 1. Create a scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  
  -- 2. Calculate window size/position (same as before)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local opts = {
    relative = "editor",
    width = width, height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal", border = "rounded",
    title = " Running: " .. command .. " ", title_pos = "center",
  }
  
  -- 3. Open the window
  local win = vim.api.nvim_open_win(buf, true, opts)
  
  -- 4. Define the callback to append text
  local append_data = function(_, data)
    if data then
      -- Filter out empty lines if necessary
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
      -- Auto-scroll to the bottom
      vim.api.nvim_win_set_cursor(win, {vim.api.nvim_buf_line_count(buf), 0})
    end
  end

  -- 5. Start the Job
  vim.fn.jobstart(command, {
    stdout_buffered = false, -- Crucial for real-time
    on_stdout = append_data,
    on_stderr = append_data,
    on_exit = function()
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "--- Process Finished ---" })
    end
  })

  -- Close window with 'q'
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
end
local function get_php_class_silent()
  -- pcall wraps the logic to catch any errors and return 'false' instead of crashing
  local status, result = pcall(function()
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Ensure we are actually in a PHP file
    if vim.bo[bufnr].filetype ~= "php" then return nil end

    -- Get the node under the cursor
    local node = vim.treesitter.get_node()
    if not node then return nil end

    -- Walk up the tree to find the class declaration
    local current = node
    while current do
      if current:type() == "class_declaration" then
        -- In PHP grammar, the 'name' field points to the class identifier
        local name_node = current:field("name")[1]
        if name_node then
          return vim.treesitter.get_node_text(name_node, bufnr)
        end
      end
      current = current:parent()
    end
    
    return nil
  end)

  -- If status is true, result is the class name (or nil). 
  -- If status is false (error), we return nil silently.
  return status and result or nil
end

local function get_php_context_silent()
  local status, result = pcall(function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].filetype ~= "php" then return nil end

    local node = vim.treesitter.get_node()
    if not node then return nil end

    local context = { class = nil, method = nil }
    local current = node

    while current do
      local type = current:type()

      -- Check for Method (Function inside a class)
      if type == "method_declaration" and not context.method then
        local name_node = current:field("name")[1]
        if name_node then
          context.method = vim.treesitter.get_node_text(name_node, bufnr)
        end
      end

      -- Check for Class
      if type == "class_declaration" and not context.class then
        local name_node = current:field("name")[1]
        if name_node then
          context.class = vim.treesitter.get_node_text(name_node, bufnr)
        end
      end

      current = current:parent()
    end

    -- Only return if we are strictly inside a method
    if context.method then
      return context
    end
    
    return nil
  end)

  return status and result or nil
end

local function roda_teste_php()
    if vim.bo.filetype ~= 'php' then
        return
    end
    local project_root = vim.fs.root(0, { ".git", "composer.json", "artisan" })
    if project_root == nil then
        return
    end

    local art_path = project_root .. '/artisan'
    local stat = vim.uv.fs_stat(art_path)
    if not(stat and stat.type == 'file') then
        return
    end
    local ctx = get_php_context_silent()
    if not ctx then
        vim.notify("Class definition not found")
        return
    end
    if not ctx.class then
        vim.notify("Class definition not found")
        return
    end
    local filter = ctx.class
    local is_test_class = ctx.class:match("Test$")
    if not is_test_class then
        return
    end
    if ctx.method then
        local is_test_method = ctx.method:match("^test")
        if is_test_method then
            filter = ctx.class .. '::' .. ctx.method
        end
    end


    local command = string.format("php %s test --filter %s", art_path, filter)
    run_realtime_float(command)
end

vim.api.nvim_create_user_command("RunTests", 
function()
    roda_teste_php()
end, 
{
nargs = 0,
desc = "Roda testes"
})
