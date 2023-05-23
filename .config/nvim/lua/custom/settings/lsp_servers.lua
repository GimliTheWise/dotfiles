-- Available servers here: https://github.com/williamboman/mason-lspconfig.nvim
return {
  -- clangd = {},
  -- gopls = {},
  --  pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
