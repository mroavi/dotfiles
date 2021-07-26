local utils = require('mrv.utils')

function MyPackerSync()
	utils.reload(true)
	vim.cmd [[ :PackerSync ]]
end

utils.remap("n", "<Leader>ps", "<Cmd>lua MyPackerSync()<CR>")

