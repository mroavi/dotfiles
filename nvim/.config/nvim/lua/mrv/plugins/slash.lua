local utils = require('mrv.utils')
utils.keymap("n", "<plug>(slash-after)", "slash#blink(1, 150)", {expr = true}) -- blink cursor after next/prev
