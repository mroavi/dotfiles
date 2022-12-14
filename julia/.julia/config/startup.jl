# ------------------------------------------------------------------------------
# Start OhMyREPL (warn if not installed)
# ------------------------------------------------------------------------------

# atreplinit() do repl
#   try
#     @eval using OhMyREPL
#     # @eval colorscheme!("OneDark")
#     @eval enable_autocomplete_brackets(false)
#     # Custom color color_scheme
#     @eval using Crayons
#     @eval import OhMyREPL: Passes.SyntaxHighlighter
#     @eval color_scheme = SyntaxHighlighter.ColorScheme()
#     @eval SyntaxHighlighter.symbol!(color_scheme,crayon"#73cef4")
#     @eval SyntaxHighlighter.comment!(color_scheme, crayon"#999999")
#     @eval SyntaxHighlighter.string!(color_scheme, crayon"#d3b987")
#     @eval SyntaxHighlighter.call!(color_scheme, crayon"#c9d05c")
#     @eval SyntaxHighlighter.op!(color_scheme, crayon"#f43753")
#     @eval SyntaxHighlighter.keyword!(color_scheme, crayon"#b3deef")
#     @eval SyntaxHighlighter.macro!(color_scheme, crayon"#b3deef")
#     @eval SyntaxHighlighter.function_def!(color_scheme, crayon"#c9d05c")
#     @eval SyntaxHighlighter.text!(color_scheme, crayon"#eeeeee")
#     @eval SyntaxHighlighter.error!(color_scheme, crayon"#f43753")
#     @eval SyntaxHighlighter.argdef!(color_scheme, crayon"#73cef4")
#     @eval SyntaxHighlighter.number!(color_scheme, crayon"#d3b987")
#     # @eval test_colorscheme(color_scheme)
#     @eval SyntaxHighlighter.add!("Tender", color_scheme)
#     @eval colorscheme!("Tender")
#   catch e
#     @warn "error while importing OhMyREPL" e
#   end
# end

# ------------------------------------------------------------------------------
# TEMP: Color paths in Stacktraces with custom color
# ------------------------------------------------------------------------------

# https://discourse.julialang.org/t/julia-1-6-stacktrace/57981/13
# Real solution is WIP: https://github.com/JuliaLang/julia/issues/41435
@eval Base begin
  path_color = :blue
  function print_stackframe(io, i, frame::StackFrame, n::Int, digit_align_width, modulecolor)
    file, line = string(frame.file), frame.line
    stacktrace_expand_basepaths() && (file = something(find_source_file(file), file))
    stacktrace_contract_userdir() && (file = contractuser(file))
    # Used by the REPL to make it possible to open
    # the location of a stackframe/method in the editor.
    if haskey(io, :last_shown_line_infos)
      push!(io[:last_shown_line_infos], (string(frame.file), frame.line))
    end
    inlined = getfield(frame, :inlined)
    modul = parentmodule(frame)
    # frame number
    print(io, " ", lpad("[" * string(i) * "]", digit_align_width + 2))
    print(io, " ")
    StackTraces.show_spec_linfo(IOContext(io, :backtrace => true), frame)
    if n > 1
      printstyled(io, " (repeats $n times)"; color=:light_black)
    end
    println(io)
    # @
    printstyled(io, " "^(digit_align_width + 2) * "@ ", color=:light_black)
    # module
    if modul !== nothing
      printstyled(io, modul, color=modulecolor)
      print(io, " ")
    end
    # filepath
    pathparts = splitpath(file)
    folderparts = pathparts[1:end-1]
    if !isempty(folderparts)
      printstyled(io, joinpath(folderparts...) * (Sys.iswindows() ? "\\" : "/"), color=path_color)
    end
    # filename, separator, line
    # use escape codes for formatting, printstyled can't do underlined and color
    # codes are bright black (90) and underlined (4)
    function print_underlined(io::IO, s...)
      colored = get(io, :color, false)::Bool
      start_s = colored ? text_colors[path_color] * "\033[4m" : ""
      end_s = colored ? "\033[0m" : ""
      print(io, start_s, s..., end_s)
    end
    print_underlined(io, pathparts[end], ":", line)
    # inlined
    printstyled(io, inlined ? " [inlined]" : "", color=path_color)
  end
end

# ------------------------------------------------------------------------------
## Clear screen leaving prompt at the bottom
# ------------------------------------------------------------------------------
function clr()
  for _ = 1:60
    println()
  end
end

# ------------------------------------------------------------------------------
# Open files in another tmux instance where nvim should already be running
# with @edit <function call> or, when a stacktrace is displayed, with [number]<C-q>
# ------------------------------------------------------------------------------
using InteractiveUtils
InteractiveUtils.define_editor("nvim", wait=false) do cmd, path, line
  # Open in pane to the left of REPL
  `tmux send-keys -t '{'left-of'}' Escape ":edit +$line $path" C-m C-h`
  # Open in window 1
  # `tmux select-window -t 0:1';' send-keys -t 0:1.0 Escape ":edit +$line $path" C-m`
end

# ------------------------------------------------------------------------------
## Find the git repo's root directory
# ------------------------------------------------------------------------------
function gitdir(currdir)
  while true
    dirname(currdir) == currdir && return nothing
    isdir(joinpath(currdir, ".git")) && return currdir
    currdir = dirname(currdir)
  end
end

# ------------------------------------------------------------------------------
## Return a date-time string to be used as directory name for a benchmark
# Format based on: https://serverfault.com/a/370766
# ------------------------------------------------------------------------------
function benchmark_dirname()
  joinpath("out", gethostname(), Dates.format(now(), "yyyy-mm-dd--HH-MM-SS"))
end

# ------------------------------------------------------------------------------
## My silent @show version (omit the right-hand side)
# ------------------------------------------------------------------------------
macro sshow(exs...)
  blk = Expr(:block)
  for ex in exs
    push!(blk.args, :(println(repr(begin
      local value = $(esc(ex))
    end))))
  end
  isempty(exs) || push!(blk.args, :value)
  return blk
end

# ------------------------------------------------------------------------------
##  Improvement to the display of stack traces in the Julia REPL
# ------------------------------------------------------------------------------

# using AbbreviatedStackTraces

# ------------------------------------------------------------------------------
# Return time and expression result
# https://discourse.julialang.org/t/save-btime-output/53595/6
# ------------------------------------------------------------------------------

# using BenchmarkTools
# @eval BenchmarkTools macro btimed(args...)
#   _, params = prunekwargs(args...)
#   bench, trial, result = gensym(), gensym(), gensym()
#   trialmin, trialallocs = gensym(), gensym()
#   tune_phase = hasevals(params) ? :() : :($BenchmarkTools.tune!($bench))
#   return esc(quote
#     local $bench = $BenchmarkTools.@benchmarkable $(args...)
#     $BenchmarkTools.warmup($bench)
#     $tune_phase
#     local $trial, $result = $BenchmarkTools.run_result($bench)
#     local $trialmin = $BenchmarkTools.minimum($trial)
#     $result, $BenchmarkTools.time($trialmin)
#   end)
# end
