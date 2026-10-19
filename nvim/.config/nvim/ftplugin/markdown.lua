-- Build the PDF for pandoc documents. Two ways are supported: a build.sh next
-- to the source, or a shared template/build-doc.sh found up the tree. The key
-- below stays unbound when neither is there, so ordinary markdown files are
-- untouched.

local dir = vim.fn.expand('%:p:h')
local cmd, pdf

if vim.fn.filereadable(dir .. '/build.sh') == 1 then
  -- cwd matters: build.sh refers to main.md and images/ relatively.
  cmd = { 'bash', 'build.sh' }
  pdf = dir .. '/main.pdf'
else
  local tpl = vim.fs.find('template', { upward = true, path = dir, type = 'directory' })[1]
  if not tpl or vim.fn.filereadable(tpl .. '/build-doc.sh') == 0 then
    return
  end
  -- The shared script takes the source file and writes <name>.pdf beside it.
  cmd = { 'bash', tpl .. '/build-doc.sh', vim.fn.expand('%:t') }
  pdf = dir .. '/' .. vim.fn.expand('%:t:r') .. '.pdf'
end

vim.keymap.set('n', '<Leader>e', function()
  vim.notify('Building ' .. vim.fn.fnamemodify(pdf, ':t') .. ' ...', vim.log.levels.INFO)

  -- Asynchronous, so the editor stays usable while pandoc and LuaLaTeX run.
  vim.system(cmd, { cwd = dir, text = true }, function(obj)
    vim.schedule(function()
      if obj.code ~= 0 then
        local output = obj.stderr ~= '' and obj.stderr or obj.stdout
        vim.notify('Build failed (' .. obj.code .. ')\n' .. output, vim.log.levels.ERROR)
        return
      end

      vim.notify('Build finished', vim.log.levels.INFO)

      -- Okular reloads the file by itself, so only launch a viewer when no
      -- process holds the PDF yet.
      if #vim.fn.systemlist({ 'lsof', pdf }) == 0 then
        vim.system({ 'xdg-open', pdf }, { detach = true })
      end
    end)
  end)
end, { buffer = true, desc = 'Build PDF' })
