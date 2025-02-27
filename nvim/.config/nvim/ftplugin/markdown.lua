-- I define build_and_open as a global function (_G.build_and_open) rather than
-- encapsulating it in a module (M) because this file's location is not
-- included in Neovim's runtime paths by default.
function _G.build_and_open()
  local build_cmd = { 'bash', '-c', 'source build.sh' }
  vim.fn.jobstart(build_cmd, {
    on_exit = function(job_id, exit_code, event)
      print("Build finished with exit code: " .. exit_code)
      -- Check if the PDF is already open by running 'lsof' on it.
      local pdf_status = vim.fn.systemlist("lsof ./workshop.pdf")
      if #pdf_status == 0 then
        print("PDF not open. Launching it...")
        vim.fn.jobstart({ 'xdg-open', './workshop.pdf' })
      else
        print("PDF is already open.")
      end
    end,
  })
end

vim.api.nvim_set_keymap('n', '<leader>e', ':lua build_and_open()<CR>', { noremap = true })
