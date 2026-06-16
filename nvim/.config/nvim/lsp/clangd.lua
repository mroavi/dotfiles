-- nvim-lspconfig also ships an `lsp/clangd.lua`, and it sits later on
-- the runtimepath than this file. A plain `return {...}` here is
-- tier-2 config and would be overridden by lspconfig's
-- `cmd`/`filetypes`. A `vim.lsp.config()` call outranks any `lsp/`
-- file, so we set our overrides through it instead.
vim.lsp.config('clangd', {
  cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
})
return {}

-- Use `bear` to generate the `compile_commands.json` file needed by clangd
-- when the project does NOT use CMake.
-- Installation: yay -S bear
-- Github page: https://github.com/rizsotto/Bear
--
-- For CMake-based projects, the recommended approach is:
--   cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
-- and then symlink the generated file into the project root:
--   ln -s build/compile_commands.json compile_commands.json
--
-- For PlatformIO projects, use the built-in target instead:
--   pio run -t compiledb
-- This generates `compile_commands.json` in the project root. Re-run it
-- whenever sources or `platformio.ini` change.
