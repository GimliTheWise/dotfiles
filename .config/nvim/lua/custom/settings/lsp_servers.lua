-- Available servers here: https://github.com/williamboman/mason-lspconfig.nvim
return {
  clangd = {},
  -- clang-format = {}, # doesn't work because of "-"
  -- codelldb = {},
  -- gopls = {},
  pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
