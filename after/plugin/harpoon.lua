local Balls = require("balls")

Balls:register("git@github.com:ThePrimeagen/harpoon.git", {
    rev = "harpoon2"
})

local ok, harpoon = pcall(require, "harpoon")

if not ok then
    return
end

harpoon:setup()
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<M-a>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<M-r>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<M-s>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<M-t>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
