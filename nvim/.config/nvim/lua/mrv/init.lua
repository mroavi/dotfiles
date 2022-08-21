--     _       _ _     _
--    (_)     (_) |   | |
--     _ _ __  _| |_  | |_   _  __ _
--    | | '_ \| | __| | | | | |/ _` |
--    | | | | | | |_ _| | |_| | (_| |
--    |_|_| |_|_|\__(_)_|\__,_|\__,_|

require('mrv.config').setup()
require('mrv.plugins').setup()
vim.cmd [[ exe "source " .. stdpath('config') .. "/lua/mrv/config.vim" ]]
