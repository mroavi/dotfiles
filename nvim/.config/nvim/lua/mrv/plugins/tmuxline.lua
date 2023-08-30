--local vim = vim
--vim.cmd [[ :Tmuxline vim_statusline_3 ]]
--vim.cmd [[ TmuxlineSnapshot /home/mroavi/dotfiles/tmux/.config/tmux/tmux.conf.statusline ]]

--vim.api.nvim_command([[
--let g:tmuxline_preset = {
--\ 'a' : '#S',
--\ 'win' : ['#I #W'],
--\ 'cwin' : ['#I #W'],
--\ 'z' : '%R',
--\ 'options': {
--\             'status-justify': 'left',
--\             'status-position': 'top',
--\ }
--}

--if $SSH_CONNECTION
--	autocmd VimEnter,ColorScheme * silent! Tmuxline lightline_insert
--endif
--]])
