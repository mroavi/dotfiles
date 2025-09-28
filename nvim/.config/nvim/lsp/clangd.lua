return {
  autostart = true,
  cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
  filetypes = { "c", "cpp", "objc", "objcpp" }
}

-- Use `bear` to generate the `compile_commands.json` file needed by clangd
-- when the project does NOT use CMake.
-- Installation: yay -S bear
-- Github page: https://github.com/rizsotto/Bear
--
-- For CMake-based projects, the recommended approach is:
--   cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
-- and then symlink the generated file into the project root:
--   ln -s build/compile_commands.json compile_commands.json
