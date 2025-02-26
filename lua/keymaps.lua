-- Define common options

local function opts(desc)
    desc = desc or ""
    return { desc =  desc,  noremap = true, silent = true }
end
-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts("Switch Left"))
vim.keymap.set("n", "<C-j>", "<C-w>j", opts("Switch Down"))
vim.keymap.set("n", "<C-k>", "<C-w>k", opts("Switch Up"))
vim.keymap.set("n", "<C-l>", "<C-w>l", opts("Switch Right"))

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts("resize -2"))
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts("resize +2"))
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts("vertical resize -2"))
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts("vertical resize +2"))

-- For nvim-tree.lua
-- default leader key: \
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts("NvimTreeToggle"))

-- split
vim.keymap.set("n", "<leader>sp", ":split<CR>", opts("Split p"))
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opts("Split v"))

-----------------
-- Visual mode --
-----------------
vim.keymap.set("n", "<space>s", ":w<CR>", opts("Save Files"))
-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts("<"))
vim.keymap.set("v", ">", ">gv", opts(">"))

-- For nvim-treesitter
-- 1. Press `gss` to intialize selection. (ss = start selection)
-- 2. Now we are in the visual mode.
-- 3. Press `gsi` to increment selection by AST node. (si = selection incremental)
-- 4. Press `gsc` to increment selection by scope. (sc = scope)
-- 5. Press `gsd` to decrement selection. (sd = selection decrement)
