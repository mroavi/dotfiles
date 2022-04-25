function MyPackerSync()
	vim.cmd [[ :PackerSync ]]
end

vim.keymap.set("n", "<Leader>ps", "<Cmd>:PackerSync<CR>")
