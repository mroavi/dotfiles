return {
  autostart = true,
  cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
  filetypes = { "c", "cpp", "objc", "objcpp" }
}

-- Use `bear` to generate the `compile_commands.json` file needed by clangd
-- Installation: yay -S bear
-- Github page: https://github.com/rizsotto/Bear
