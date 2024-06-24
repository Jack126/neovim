local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n", 
  "<leader>a", 
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", "<space>f", 
    function ()
        vim.cmd.RustFmt()
        vim.fn.execute("silent! write")
    end,
    {}
)
vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
      on_attach = function(client, bufnr)
        -- you can also put keymaps in here
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
            ["cargo.targetDir"] = true,
            -- ["rustfmt.overrideCommand"] = { "rustfmt"},
            -- Additional settings appended here
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
            },
            checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
            },
            procMacro = {
                enable = true,
                ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                },
            },
        },
      },
    },
    -- DAP configuration
    dap = {
    },
  }
  