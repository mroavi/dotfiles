"" No space between comment character and code
"let b:commentary_format = '#%s'

"lua << EOF
"-- Specific language configuration
"require('kommentary.config').configure_language("julia", {
"  single_line_comment_string = "#",
"  prefer_single_line_comments = true,
"})
"EOF

