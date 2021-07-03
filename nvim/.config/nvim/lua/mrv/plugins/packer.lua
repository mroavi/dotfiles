local utils = require('mrv.utils')
-- TODO: consider reloading the config before executing :PackerSync
utils.remap("n", "<Leader>ps", "<Cmd>:PackerSync<CR>")
