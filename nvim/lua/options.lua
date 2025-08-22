require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
-- NOTE 自动将 nvim 的工作目录更改为启动时提供的目录参数
-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   callback = function()
--     -- vim.fn.argc() 返回启动参数的数量
--     -- vim.fn.argv(0) 返回第一个参数
--     -- vim.fn.isdirectory() 检查路径是否为目录
--     if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
--       -- 如果只有一个参数且该参数是一个目录，则执行 :cd 命令
--       vim.cmd.cd(vim.fn.argv(0))
--       vim.cmd("NvimTreeFindFile")
--     end
--   end,
-- })


-- NOTE 快速退出
--
-- NOTE 项目目录 与 切换目录
