vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { desc = "[F]ile[T]ree", noremap = true })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
    { desc = "[F]ile[T]ree", noremap = true })
