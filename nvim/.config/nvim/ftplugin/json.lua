-------------------------------------------------------------------------------
-- conform
-------------------------------------------------------------------------------

-- Install `prettier` with Mason

-- Enable formatting using the gq operator
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
