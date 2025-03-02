-- I define build_and_open as a global function (_G.build_and_open) rather than
-- encapsulating it in a module (M) because this file's location is not
-- included in Neovim's runtime paths by default.
function _G.build_and_open()
  local build_cmd = { 'bash', '-c', 'source build.sh' }
  vim.fn.jobstart(build_cmd, {
    on_exit = function(job_id, exit_code, event)
      print("Build finished with exit code: " .. exit_code)
      -- Check if the PDF is already open by running 'lsof' on it.
      local pdf_status = vim.fn.systemlist("lsof ./main.pdf")
      if #pdf_status == 0 then
        print("PDF not open. Launching it...")
        vim.fn.jobstart({ 'xdg-open', './main.pdf' })
      else
        print("PDF is already open.")
      end
    end,
  })
end

-- Global flag to track activation
_G.build_on_save = false

-- Auto-run function after saving the file, but only if _G.build_on_save is true
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "main.md",  -- Change this to match your file
  callback = function()
    if _G.build_on_save then
      build_and_open()
    end
  end,
})

-- Keybinding using a function
vim.keymap.set('n', '<LocalLeader>ll', function()
  _G.build_on_save = true
  print("Auto-build enabled. Running build process...")
  vim.notify("Auto-build enabled. Running build process...", vim.log.levels.INFO)
  build_and_open()
end, { noremap = true })
