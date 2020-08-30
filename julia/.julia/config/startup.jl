# using OhMyREPL; colorscheme!("Base16MaterialDarker") # TODO: breaks slime

# Clear screen leaving prompt at the bottom
function clr()
  for i = 1:60
    println()
  end
end

# https://github.com/Moelf/JLFzf.jl
import REPL
import REPL.LineEdit
import JLFzf
const mykeys = Dict{Any,Any}(
    # primary history search: most recent first
    "^R" => function (mistate, o, c)
        line = JLFzf.inter_fzf(JLFzf.read_repl_hist(), "--read0", "--tiebreak=index");
        JLFzf.insert_history_to_repl(mistate, line)
    end,
)
function customize_keys(repl)
    repl.interface = REPL.setup_interface(repl; extra_repl_keymap = mykeys)
end
atreplinit(customize_keys)
