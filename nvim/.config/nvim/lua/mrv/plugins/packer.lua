local utils = require('mrv.utils')

function MyPackerSync()
	vim.cmd [[ :PackerSync ]]
end

utils.remap("n", "<Leader>ps", "<Cmd>:PackerSync<CR>")

