vim.g.vimtex_view_method = 'zathura'
vim.keymap.set("n", "<leader>rb", ":!bibtex-tidy --align --space=4 --duplicates --merge=combine %:p")
