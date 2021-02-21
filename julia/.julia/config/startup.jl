# Start OhMyREPL (warn if not installed)
atreplinit() do repl
  try
    @eval using OhMyREPL
    @eval colorscheme!("Base16MaterialDarker")
    @eval enable_autocomplete_brackets(false)
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


#=----------------------------------------------------------------------------=#
# JULIA TIPS AND TRICKS
#=----------------------------------------------------------------------------=#

#=----------------------------- List of Handy Macros ---------------------------

  @which          <function/macro>
  @edit           <function/macro>
  @debug          <string message> [key=value | value ...]

  @code_lowered   <function/macro>
  @code_typed     <function/macro>
  @code_llvm      <function/macro>
  @code_native    <function/macro>
  @code_warntype  <function/macro>

To enable @debug messages, you need to set the JULIA_DEBUG environment var:

  julia> ENV["JULIA_DEBUG"] = "all"


----------------------------------- REPL History -------------------------------

Type the beginning of a command and type Ctrl-p to browse through all commands
in history that begin with the same chars. For example:

  julia> ENV<CTRL+P>

completes to:

  julia> ENV["JULIA_DEBUG"] = "all"

Type Ctrl-R in the REPL to start FZF to filter the REPL History


# ----------------------------------- Debugger ---------------------------------

  julia> using Debugger       # import the julia debugger
  julia> @enter <function>    # run <function> in debugger mode
  debug> ?                    # list the help to see all debugger available cmds
  debug> `                    # go to julia mode keeping the backtrace (backspace to leave)
  |julia> print(x)            # print the content of `x`
  |julia> x = 2               # assign the value 2 to `x`

------------------------------------------------------------------------------=#
