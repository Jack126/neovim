local present, wk = pcall(require, 'which-key')


if present then
    -- 定义一个查找相关的映射组
    vim.keymap.set("n", "<leader>ff", function() print("查找文件") end, { desc = "查找文件" })
    vim.keymap.set("n", "<leader>fg", function() print("全局搜索") end, { desc = "全局搜索" })
    vim.keymap.set("n", "<leader>fb", function() print("查找缓冲区") end, { desc = "查找缓冲区" })
    -- 注册查找相关的映射组提示
    wk.register({
        ["<leader>"] = {
            f = {
                name = "查找",
                f = { "查找文件" },
                g = { "全局搜索" },
                b = { "查找缓冲区" }
            }
        }
    })
end
