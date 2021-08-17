local M = {}

M.setup = function()
	require'compe'.setup {
		documentation = {
			border = "rounded",
		};
		source = {
			path = true;
			buffer = true;
			calc = true;
			nvim_lsp = true;
			nvim_lua = true;
			vsnip = true;
			ultisnips = false;
			luasnip = false;
      latex_symbols = true;
			spell ={filetypes={"gitcommit","markdown"},}
		};
	}
end

---------------------------------------------------------------------------------
-- How to use tab to navigate completion menu? (from README)
---------------------------------------------------------------------------------

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-n>"
	elseif vim.fn['vsnip#available'](1) == 1 then
		return t "<Plug>(vsnip-expand-or-jump)"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return vim.fn['compe#complete']()
	end
end
_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-p>"
	elseif vim.fn['vsnip#jumpable'](-1) == 1 then
		return t "<Plug>(vsnip-jump-prev)"
	else
		-- If <S-Tab> is not working in your terminal, change it to <C-h>
		return t "<S-Tab>"
	end
end

---------------------------------------------------------------------------------
-- Mappings
---------------------------------------------------------------------------------

local utils = require('mrv.utils')

utils.remap("i", "<C-Space>", "compe#complete()", {expr = true, noremap = true}) -- trigger completion menu
utils.remap("i", "<C-e>", "compe#close('<C-e>')", {expr = true, noremap = true}) -- close completion menu

-- Select option from completion menu
-- utils.remap("i", "<CR>", "compe#confirm('<CR>')", {expr = true, noremap = true})
-- utils.remap("i", "<CR>", "compe#confirm({ 'keys': \"\\<Plug>delimitMateCR\", 'mode': '' })", {expr = true}) -- compatitbility with DelimitMate
vim.cmd [[ inoremap <silent><expr> <CR> compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()")) ]] -- compatitbility with nvim-autopairs

utils.remap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
utils.remap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
utils.remap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
utils.remap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

M.setup()

return M
