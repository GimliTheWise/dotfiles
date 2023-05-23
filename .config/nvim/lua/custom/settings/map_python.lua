vim.keymap.set("n", "<leader>rp", ":w !python<CR>")
vim.keymap.set("n", "<leader>wp", ":w<CR>:!autopep8 --in-place --aggressive --aggressive %<CR>:e!<CR>")
