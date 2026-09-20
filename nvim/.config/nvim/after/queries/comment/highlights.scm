;; extends

;; Highlight `DEBUG` like the built-in TODO/NOTE/FIXME keywords.
((tag
  (name) @comment.debug @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.debug "DEBUG"))

("text" @comment.debug @nospell
  (#any-of? @comment.debug "DEBUG"))
