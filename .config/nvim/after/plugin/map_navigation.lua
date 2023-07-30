vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Explore Files' })
vim.keymap.set('c', 'w!!', "w !sudo tee > /dev/null %<CR>:e!<CR>", { silent = true, desc = 'Write with sudo' })
vim.keymap.set("n", "<leader>rc", [[<Cmd>CMakeRun<CR>]], { desc = 'CMakeRun' })
