-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>fo", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

vim.g.coq_settings = {
  auto_start = "shut-up",
}
local coq = require("coq")

-- Python
require("lspconfig").pyright.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  flags = lsp_flags,
}))
require("lspconfig").ruff_lsp.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))

-- TypeScript
require("lspconfig").tsserver.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  flags = lsp_flags,
}))
require("lspconfig").eslint.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))

-- TerraForm
require("lspconfig").terraformls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))
require("lspconfig").tflint.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))

-- Lua
require("lspconfig").sumneko_lua.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
}))

-- YAML
require("lspconfig").yamlls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))
