-- https://stackoverflow.com/a/9173416/1706778
-- Make sure to have the "inspect" lib installed:
--  luarocks install --local inspect
dump = function(...)
  local str = ""
  for _, v in ipairs({...}) do
    str = str .. require("inspect")(v)
  end
  print(str)
end
