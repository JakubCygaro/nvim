-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen

local lsp_status = require 'lsp-status';
lsp_status.register_progress();
lsp_status.config({
    indicator_errors = '',
    indicator_warnings = '',
    indicator_info = '',
    indicator_hint = '',
    indicator_ok = '',
    show_filename = false,
    component_separator = '|',
    current_function = true,
})
-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

require("mason").setup({

})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "omnisharp",
        "clangd",
        "html",
        "intelephense",
        "cmake",
        "cssls",
        "gopls",
        "pylsp"
    }
})
local lspconfig = require 'lspconfig'

vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy",
            },
            diagnostics = {
                enable = true,
            },
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    },
    capabilities = lsp_status.capabilities,
    on_attach = lsp_status.on_attach
    --capabilities = lspconfig_defaults.capabilities
})

-- clangd config
lspconfig.clangd.setup{
    cmd = {
        "clangd",
        "--fallback-style=webkit",
        '--background-index',
        --'--query-driver=\'x86_64-w64-mingw32-g++\',\'x86_64-w64-mingw32-gcc\'',
        '--enable-config',
        '--compile-commands-dir=./compile_commands.json'
    },
    init_options = {
        clangdFileStatus = true,
        clangdSemanticHighlighting = true
    },
    filetypes = { 'c', 'cpp', 'cxx', 'cc' },
    root_dir = function(fname)
        return require('lspconfig.util').root_pattern('.git', '.clangd')(fname) or
            vim.fn.getcwd()
    end,
    settings = {
        clangd = {
            fallbackFlags = {
                '-std=c++17'
            },
            arguments = {
                '--enable-config'
            }
        }
    },
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
}
-- vim.lsp.config('clangd', {
--     cmd = {
--         "clangd",
--         "--fallback-style=webkit",
--         '--background-index',
--         --'--query-driver=\'x86_64-w64-mingw32-g++\',\'x86_64-w64-mingw32-gcc\'',
--         '--enable-config',
--         '--compile-commands-dir=./compile_commands.json'
--     },
--     init_options = {
--         clangdFileStatus = true,
--         clangdSemanticHighlighting = true
--     },
--     filetypes = { 'c', 'cpp', 'cxx', 'cc' },
--     root_dir = function(fname)
--         return require('lspconfig.util').root_pattern('.git', '.clangd')(fname) or
--             vim.fn.getcwd()
--     end,
--     settings = {
--         clangd = {
--             fallbackFlags = {
--                 '-std=c++17'
--             },
--             arguments = {
--                 '--enable-config'
--             }
--         }
--     },
--     on_attach = lsp_status.on_attach,
--     capabilities = lsp_status.capabilities
-- })

-- lua_ls config
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('lua_ls', ({
    -- on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files and plugins
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}))

lspconfig.omnisharp.setup {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities,
    cmd = {
        "omnisharp.cmd"
    },
    settings = {
        FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = true,
        },
        MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            LoadProjectsOnDemand = false,
        },
        RoslynExtensionsOptions = {
            -- Enables support for roslyn analyzers, code fixes and rulesets.
            EnableAnalyzersSupport = true,
            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            EnableImportCompletion = nil,
            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            AnalyzeOpenDocumentsOnly = false,
        },
        Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
        },
    },
}
-- vim.lsp.config['omnisharp'] = {
--     on_attach = lsp_status.on_attach,
--     capabilities = lsp_status.capabilities,
--     cmd = {
--         "omnisharp"
--     },
--     settings = {
--         FormattingOptions = {
--             -- Enables support for reading code style, naming convention and analyzer
--             -- settings from .editorconfig.
--             EnableEditorConfigSupport = true,
--             -- Specifies whether 'using' directives should be grouped and sorted during
--             -- document formatting.
--             OrganizeImports = true,
--         },
--         MsBuild = {
--             -- If true, MSBuild project system will only load projects for files that
--             -- were opened in the editor. This setting is useful for big C# codebases
--             -- and allows for faster initialization of code navigation features only
--             -- for projects that are relevant to code that is being edited. With this
--             -- setting enabled OmniSharp may load fewer projects and may thus display
--             -- incomplete reference lists for symbols.
--             LoadProjectsOnDemand = false,
--         },
--         RoslynExtensionsOptions = {
--             -- Enables support for roslyn analyzers, code fixes and rulesets.
--             EnableAnalyzersSupport = true,
--             -- Enables support for showing unimported types and unimported extension
--             -- methods in completion lists. When committed, the appropriate using
--             -- directive will be added at the top of the current file. This option can
--             -- have a negative impact on initial completion responsiveness,
--             -- particularly for the first few completion sessions after opening a
--             -- solution.
--             EnableImportCompletion = nil,
--             -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
--             -- true
--             AnalyzeOpenDocumentsOnly = false,
--         },
--         Sdk = {
--             -- Specifies whether to include preview versions of the .NET SDK when
--             -- determining which version to use for project loading.
--             IncludePrereleases = true,
--         },
--     },
-- }
-- html config
vim.lsp.config('html', {})

-- digestif config
vim.lsp.config('digestif', {})

-- intelephense config
vim.lsp.config('intelephense', {
    filetypes = { "php" },
    root_dir = function(_)
        local cwd = vim.fn.getcwd();
        return cwd
    end,
})

-- jdtls config
vim.lsp.config('jdtls', {})

-- cmake config
vim.lsp.config('cmake', {})

-- ts_ls config
vim.lsp.config('ts_ls', {})

-- cssls config
vim.lsp.config('cssls', {})

-- pylsp config
vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                jedi = {
                    environment = 'py.exe'
                }
            }
        }
    }
})

-- gopls config
vim.lsp.config('gopls', {})
