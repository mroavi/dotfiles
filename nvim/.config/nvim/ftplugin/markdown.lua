-- Build the PDF for pandoc documents that keep a build.sh next to the source.
-- The key below is only mapped when such a script is actually there, so it
-- stays unbound in ordinary markdown files.

local dir = vim.fn.expand('%:p:h')

if vim.fn.filereadable(dir .. '/build.sh') == 0 then
  return
end

vim.keymap.set('n', '<Leader>e', function()
  vim.notify('Building main.pdf ...', vim.log.levels.INFO)

  -- Asynchronous, so the editor stays usable while pandoc and LuaLaTeX run.
  -- cwd matters: build.sh refers to main.md and images/ relatively.
  vim.system({ 'bash', 'build.sh' }, { cwd = dir, text = true }, function(obj)
    vim.schedule(function()
      if obj.code ~= 0 then
        local output = obj.stderr ~= '' and obj.stderr or obj.stdout
        vim.notify('Build failed (' .. obj.code .. ')\n' .. output, vim.log.levels.ERROR)
        return
      end

      vim.notify('Build finished', vim.log.levels.INFO)

      -- Okular reloads the file by itself, so only launch a viewer when no
      -- process holds main.pdf yet.
      local pdf = dir .. '/main.pdf'
      if #vim.fn.systemlist({ 'lsof', pdf }) == 0 then
        vim.system({ 'xdg-open', pdf }, { detach = true })
      end
    end)
  end)
end, { buffer = true, desc = 'Build PDF with build.sh' })
