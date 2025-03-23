-- Run :TSInstall comment to enable syntax highlighting for the words ERROR, WARN, NOTE, and TODO

require 'nvim-treesitter.configs'.setup {

  -- One of "all" or a list of languages
  ensure_installed = {
    "arduino",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "html",
    "javascript",
    "json",
    "julia",
    "lua",
    "python",
    "rust",
    "sql",
    "vim",
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- List of languages that will be disabled
    disable = {
      --"julia",
      --"help",
      --"markdown",
      --"latex",
      --"gitcommit",
      --"arduino",
    },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
    -- List of filetypes for which treesitter-based indentation is disabled
    --disable = { "python", "yaml" },
  },

  -- Incremental selection based on the named nodes from the grammar
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'van',
      node_incremental = '.',
      node_decremental = ',',
    },
  },

  -- Text objects extension (https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to add jumps to the jumplist
      goto_next_start = {
        [']]'] = '@function.outer',
      },
      goto_next_end = {
        [']['] = '@function.outer',
      },
      goto_previous_start = {
        ['[['] = '@function.outer',
      },
      goto_previous_end = {
        ['[]'] = '@function.outer',
      },
    },
  },

}
