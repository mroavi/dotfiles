local utils = require('mrv.utils')
utils.remap("n", "<plug>(slash-after)", "slash#blink(1, 150)", {expr = true}) -- blink cursor after next/prev

