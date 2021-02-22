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

# Open files in a right-of tmux pane where nvim should already be running
# with @edit and <stacktrace number> followed by Ctrl-q
using InteractiveUtils
InteractiveUtils.define_editor(
  "nvim", wait=false) do cmd, path, line
  `tmux send-keys -t '{'left-of'}' Escape ":edit +$line $path" C-m C-h`
end

#=----------------------------------------------------------------------------=#
# JULIA TIPS AND TRICKS
#=----------------------------------------------------------------------------=#

#=----------------------------- List of Handy Macros ---------------------------

@edit           <function/macro>
@debug          <string message> [key=value | value ...]
  To enable @debug messages, you need to set the JULIA_DEBUG environment var:
  julia> ENV["JULIA_DEBUG"] = "all"

# ------------------- View Code at different Compiling Stages ------------------

@code_lowered   <function/macro>
@code_typed     <function/macro>
@code_llvm      <function/macro>
@code_native    <function/macro>

@code_warntype  <function/macro>

-------------------------------- Methods Available -----------------------------

Write a function in the REPL with the opening parenthesis and type <Tab>

Another option is tu use the @which macro:
  @which <function/macro>

You can also query Julia to output all methods that take a certain type of
argument with:
  methodswith(typ[, module or function]; supertypes::Bool=false])

----------------------------------- REPL History -------------------------------

Type the beginning of a command and type Ctrl-p to browse through all commands
in history that begin with the same chars. For example:

  julia> ENV<CTRL+P>

completes to:

  julia> ENV["JULIA_DEBUG"] = "all"

Type Ctrl-R in the REPL to start FZF to filter the REPL History

----------------------------------- REPL Propose -------------------------------

Search available docstrings for entries containing pattern.
When pattern is a string, case is ignored. Results are printed to io.
  apropos([io::IO=stdout], pattern::Union{AbstractString,Regex})

# ----------------------------------- Debugger ---------------------------------

  julia> using Debugger       # import the julia debugger
  julia> @enter <function>    # run <function> in debugger mode
  debug> ?                    # list the help to see all debugger available cmds
  debug> `                    # go to julia mode keeping the backtrace (backspace to leave)
  |julia> print(x)            # print the content of `x`
  |julia> x = 2               # assign the value 2 to `x`

------------------------------------------------------------------------------=#
