" https://superuser.com/questions/632657/how-to-setup-vim-to-edit-both-makefile-and-normal-code-files

" In makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
setlocal noexpandtab shiftwidth=8 softtabstop=0


