# Start OhMyREPL (warn if not installed)
atreplinit() do repl
  try
    @eval using OhMyREPL
    @eval colorscheme!("Base16MaterialDarker")
  catch e
    @warn "error while importing OhMyREPL" e
  end
end

# Clear screen leaving prompt at the bottom
function clr()
  for i = 1:60
    println()
  end
end
