require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- 快速保存 -- 保存当前buffer C-s -- :wENTER
map("n", "<C-s>","<cmd>w<CR>", { desc = "General save file" })
-- 快速保存 -- 保存所有修改 C-S-s
-- 快速退出 -- 关闭所有内容不做任何修改 C-S-q
-- 快速退出 -- 关闭当前buffer不做任何修改 C-q 
-- 快速退出 -- 关闭当前窗口 -q

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
