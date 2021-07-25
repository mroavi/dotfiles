-- Global defaults configuration
require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})

vim.g.kommentary_create_default_mappings = false

local utils = require('mrv.utils')
utils.remap("n", "gcc", "<Plug>kommentary_line_default", {noremap = false})
utils.remap("n", "gc", "<Plug>kommentary_motion_default", {noremap = false})
utils.remap("x", "gc", "<Plug>kommentary_visual_default<Esc>", {noremap = false}) -- escape after plug action

