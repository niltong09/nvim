local Balls = require('balls')

Balls:register("git@github.com:nvim-lualine/lualine.nvim.git", {
    name = 'lualine'
})

local ok, lualine = pcall(require, 'lualine')

if not ok then
    return
end

lualine.setup({
    options = {
        theme = 'papercolor_dark',
    }
})
