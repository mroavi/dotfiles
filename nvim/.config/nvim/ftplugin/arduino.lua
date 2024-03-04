---------------------------------------------------------------------------------
--- cmp
---------------------------------------------------------------------------------

-- Disable a given source for this filetype
local cmp = require('cmp')
local sources = cmp.get_config().sources
for i = #sources, 1, -1 do
  if sources[i].name == 'buffer' then
    table.remove(sources, i)
  end
end
cmp.setup.buffer({ sources = sources })
