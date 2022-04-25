local M = {}

M.reload = function(verbose)
  require("plenary.reload").reload_module("mrv")
  require("mrv")
  if verbose == true then
    print("Configuration reloaded")
  end
end

return M
