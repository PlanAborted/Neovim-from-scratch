local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local macOsMapAlt = require("user.utility").macOsMapAlt

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- On MacOs <A-key> returns a specific char
-- <A-h> = ˙
-- <A-j> = ∆
-- <A-k> = ˚
-- <A-l> = ¬

-- Resize windows (splits)
--[[ keymap("n", "˙", ":resize -2<CR>", opts) ]]
--[[ keymap("n", "¬", ":resize +2<CR>", opts) ]]
keymap("n", macOsMapAlt("<A-h>"), ":vertical resize -2<CR>", opts)
keymap("n", macOsMapAlt("<A-l>"), ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("i", macOsMapAlt("<A-j>"), "<Esc>:m .+1<CR>==gi", opts)
keymap("i", macOsMapAlt("<A-k>"), "<Esc>:m .-2<CR>==gi", opts)
keymap("n", macOsMapAlt("<A-j>"), ":m .+1<CR>==", opts)
keymap("n", macOsMapAlt("<A-k>"), ":m .-2<CR>==", opts)
keymap("v", macOsMapAlt("<A-j>"), ":m .+1<CR>==", opts)
keymap("v", macOsMapAlt("<A-k>"), ":m .-2<CR>==", opts)
keymap("x", macOsMapAlt("<A-j>"), ":m '>+1<CR>gv-gv", opts)
keymap("x", macOsMapAlt("<A-k>"), ":m '<-2<CR>gv-gv", opts)

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual paste
keymap("v", "p", '"_dP', opts)

-- Smart Cursor --
keymap("n", "o", 'o<cmd>lua require("smart-cursor").indent_cursor()<cr>', opts)
keymap("n", "O", 'O<cmd>lua require("smart-cursor").indent_cursor()<cr>', opts)

-- Global marks --
--[[ keymap("n", "m", "'m'.toupper(nr2char(getchar()))", { silent = true, noremap = true, expr = true }) ]]
--[[ keymap("n", "'", [["'".toupper(nr2char(getchar()))], { silent = true, noremap = true, expr = true }) ]]

-- Colon - Semi colon --
keymap("n", ";", ":", opts)
keymap("v", ";", ":", opts)

-- Plugins
-- Hop
keymap("n", "s", "<cmd>HopPattern<cr>", opts)

-- Harpoon
keymap("n", "mt", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)
keymap("n", "mm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
keymap("n", "ma", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts)
keymap("n", "ms", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts)
keymap("n", "md", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", opts)
keymap("n", "mf", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", opts)
