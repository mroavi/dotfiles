local M = {}
local fzf = require("fzf-lua")

fzf.setup({
  winopts = {
    height = 0.96,
    width  = 0.96,
  },
  keymap = {
    fzf = {
      true,
      ["ctrl-q"] = "select-all+accept", -- send all items to the quickfix list
    },
  },
})

-- If `dir` is inside a git repo, return the git repo's root dir, otherwise, `nil`
local function get_git_root(dir)
  dir = dir or vim.fn.expand("%:p:h")
  if dir == "" or vim.fn.isdirectory(dir) == 0 then return nil end
  local cmd = string.format('git -C %q rev-parse --show-toplevel', dir)
  local result = vim.fn.systemlist(cmd)
  return (vim.v.shell_error == 0 and result[1] ~= "") and result[1] or nil
end

-- Use git_files if in a git repo, otherwise fallback to files in the buffer's directory
function M.my_find_files()
  local buf_dir = vim.fn.expand("%:p:h")
  local git_root = get_git_root(buf_dir)
  if git_root then
    fzf.git_files({
      cwd = git_root,
      -- Show tracked + untracked, but keep ignored hidden
      cmd = "git ls-files --cached --others --exclude-standard",
    })
  else
    fzf.files({ cwd = buf_dir })
  end
end

vim.keymap.set("n", "<Leader>o", M.my_find_files)

vim.keymap.set("n", "<Leader>.", function() fzf.files({ cwd = "~/dotfiles" }) end)
vim.keymap.set("n", "<Leader>n", function() fzf.files({ cwd = "~/notes" }) end)
vim.keymap.set("n", "<C-p>", fzf.oldfiles)
vim.keymap.set("n", "<Leader>a", fzf.args)

vim.keymap.set("n", "<Leader>/", fzf.live_grep)
vim.keymap.set("n", "<Leader>?", fzf.grep_cword)
vim.keymap.set("x", '<Leader>/', fzf.grep_visual)

vim.keymap.set("n", "<Leader>k", fzf.helptags)
vim.keymap.set("n", "<Leader>K", fzf.keymaps)

vim.keymap.set("n", "grr", fzf.lsp_references	)

return M
