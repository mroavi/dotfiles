Julia tips and tricks
=====================

Open file in stacktrace
-----------------------

In the REPL, enter the stacktrace number followed by <kbd>Ctrl</kbd>+<kbd>q</kbd>

```julia
julia> map("hola")
  Stacktrace:
  [1] map(f::String)
    @ Base ./abstractarray.jl:2859
  [2] top-level scope
    @ REPL[15]:1
julia> 1<C-q>
```

List of Handy Macros
--------------------

```julia
@edit           <function call/macro call>
@debug          <string message> [key=value | value ...]
```

To enable @debug messages, you need to set the JULIA_DEBUG environment var:
```julia
julia> ENV["JULIA_DEBUG"] = "all"
```

View Code at different Compiling Stages
---------------------------------------

```julia
@code_lowered   <function/macro>
@code_typed     <function/macro>
@code_llvm      <function/macro>
@code_native    <function/macro>

@code_warntype  <function/macro>
```

Methods Available
-----------------

Write a function in the REPL with the opening parenthesis and type <kbd>Tab</kbd>

Another option is to use the `@which` macro:
```julia
@which <function/macro>
```

You can also query Julia to output all methods that take a certain type of
argument with:
```julia
methodswith(typ[, module or function]; supertypes::Bool=false])
```

REPL History
------------

Type the beginning of a command and type <kbd>Ctrl</kbd>+<kbd>p</kbd> to browse
through all commands in history that begin with the same chars. For example:

```julia
julia> ENV<CTRL+P>
```
completes to:
```julia
julia> ENV["JULIA_DEBUG"] = "all"
```

With OhMyREPL, type <kbd>Ctrl</kbd>+<kbd>R</kbd> in the REPL to start FZF to
filter the REPL History

REPL Propose
------------

Search available docstrings for entries containing pattern. When pattern is a
string, case is ignored. Results are printed to io.

```julia
apropos([io::IO=stdout], pattern::Union{AbstractString,Regex})
```

Debugger
--------

```
julia> using Debugger       # import the julia debugger
julia> @enter <function>    # run <function> in debugger mode
debug> ?                    # list the help to see all debugger available cmds
debug> `                    # go to julia mode keeping the backtrace (backspace to leave)
|julia> print(x)            # print the content of `x`
|julia> x = 2               # assign the value 2 to `x`
```

