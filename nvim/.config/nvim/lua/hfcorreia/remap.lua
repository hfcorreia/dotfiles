-- Define the mapleader
vim.g.mapleader = ","

-- This unsets the 'last search pattern' register by hitting <esc><esc>
vim.keymap.set("n", "<esc><esc>", ":noh<cr>")
vim.keymap.set("i", "jk", "<esc>", { noremap = true })

-- This keeps the cursor in the middle of the screen when navigating
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Better joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keeps the cursor in the middle of the screen when scrolling and searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search next/previous keeps the cursor in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over currently selected text without yanking it
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Does a rename of the word under the cursor in the whole file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Toggle quickfix window
local function toggle_quickfix()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
    else
        vim.cmd "copen"
    end
end
vim.keymap.set("n", "<leader>q", toggle_quickfix, { desc = "Toggle quickfix window" })
