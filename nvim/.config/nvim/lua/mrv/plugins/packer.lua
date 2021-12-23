local utils = require('mrv.utils')

function MyPackerSync()
	vim.cmd [[ :PackerSync ]]
end

utils.keymap("n", "<Leader>ps", "<Cmd>:PackerSync<CR>")

