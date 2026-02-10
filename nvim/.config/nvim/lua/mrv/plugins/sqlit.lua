-- Installation: yay -S sqlit

local options = {}
require("sqlit").setup(options)

vim.keymap.set("n", "<leader>D", function() require("sqlit").open() end, { desc = "Database (sqlit)" })
