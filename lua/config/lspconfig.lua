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

local on_attach = function(client)
    require 'completion'.on_attach(client)
end
if lspconfig.rust_analyzer then
	require 'lspconfig'.rust_analyzer.setup {
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
	}
end

local get_data_path = function()
    local data_path = vim.fn.stdpath('data');
    return data_path;
end
local function exe_ext()
    if jit.os == "Windows" then
        return ".exe"
    else
        return ""
    end
end
local function get_clangd_setup()
    local nvim_data_path = get_data_path();
    local ext = exe_ext();
    local mingw64 = ""
    local cc = "gcc"
    local cxxc = "g++"
    local add_cxxc_include = ""
    if jit.os == 'Windows' then
        mingw64 = '--include=C:/msys64/mingw64/include'
        cc = "x86_64-w64-mingw32-gcc"
        cxxc = "x86_64-w64-mingw32-g++"
    end

    return {
        -- clangd_path = nvim_data_path ..'/mason/packages/clangd/clangd_19.1.2/bin/clangd' .. ext,
        add_cc_include = mingw64,
        add_cxxc_include = add_cxxc_include,
        cc = cc,
        cxxc = cxxc
    }
end

local clangd_setup = get_clangd_setup()
if lspconfig.clangd then

	require 'lspconfig'.clangd.setup {
	    cmd = {
		"clangd",
		"--fallback-style=webkit",
		-- clangd_setup.clangd_path,
		--'clangd',
		--'--project-root='.. vim.fn.getcwd(),
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
	    -- root_dir = function(fname)
	    --     return require("lspconfig.util").root_pattern(
	    --         "Makefile",
	    --         "configure.ac",
	    --         "configure.in",
	    --         "config.h.in",
	    --         "meson.build",
	    --         "meson_options.txt",
	    --         "build.ninja"
	    --     )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
	    --         fname
	    --     ) or require("lspconfig.util").find_git_ancestor(fname)
	    -- end,
	    root_dir = function(fname)
		return require('lspconfig.util').root_pattern('.git', '.clangd')(fname) or
			vim.fn.getcwd()
	    end,
	    settings = {
		clangd = {
		    --          compilationDatabasePath = 'clangdbuild',
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
	    --settings = {
	    --    ['clangd'] = {
	    --        ['compilationDatabasePath'] = 'build',
	    --        ['fallbackFlags'] = {'-std=c++17'},
	    --        ['CompileFlags'] = {
	    --            ['Compiler'] = {
	    --                clangd_setup.cc
	    --            },
	    --            ['Add'] = {
	    --                clangd_setup.add_cc_include
	    --            }
	    --        },
	    --        --['---'] = {
	    --        --    ['If'] = {
	    --        --        ['PathMatch'] = '.*\\.cpp .*\\.cxx .*\\.cc .*\\.hpp'
	    --        --    },
	    --        --    ['Compiler'] = {
	    --        --        clangd_setup.cxxc
	    --        --    },
	    --        --    ['Add'] = {
	    --        --        clangd_setup.add_cxxc_include
	    --        --    }
	    --        --},
	    --        --string.format(
	    --        --[[
	    --        --If:
	    --        --    PathMatch: .*\.c .*\.h
	    --        --CompileFlags:
	    --        --    Compiler: %s
	    --        --    Add: [%s]
	    --        --If:
	    --        --    PathMatch: .*\.cpp .*\.cxx .*\.cc .*\.hpp
	    --        --CompileFlags:
	    --        --    Compiler: %s
	    --        --    Add: [%s]
	    --        --]]
	    --        --, clangd_setup.cc, clangd_setup.add_cc_include,
	    --        --    clangd_setup.cxxc, clangd_setup.add_cc_include)
	    --        --['If'] = {
	    --        --    ['PathMatch'] = '.*\\.c .*\\.h'
	    --        --},
	    --        --['CompileFlags'] = {
	    --        --    ['Compiler'] = {
	    --        --        clangd_setup.cc
	    --        --    },
	    --        --    ['Add'] = {
	    --        --        clangd_setup.add_include
	    --        --    }
	    --        --}
	    --    }
	    --}
	}
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
if lspconfig.lua_ls then

	require 'lspconfig'.lua_ls.setup({
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
	})
end
local function get_omnisharp_setup()
    local nvim_data_path = get_data_path();
    --local ext = exe_ext();
    local dll = ""
    if jit.os == 'Windows' then
        dll = '.dll'
    end
    return {
        omnisharp_path = nvim_data_path .. '/mason/packages/omnisharp/libexec/OmniSharp' .. dll,
    }
end
local omnisharp_setup = get_omnisharp_setup()
if lspconfig.omnisharp then

	require 'lspconfig'.omnisharp.setup {
	    on_attach = lsp_status.on_attach,
	    capabilities = lsp_status.capabilities,
	    cmd = {
		"dotnet",
		omnisharp_setup.omnisharp_path
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
end
if lspconfig.html then
	require 'lspconfig'.html.setup {

	}
end
if lspconfig.digestif then 
	require 'lspconfig'.digestif.setup {}
end
-- require'lspconfig'.tectonic.setup {}
--require'lspconfig'.oxlint.setup {
--
--}
--local configs = require 'nvim_lsp/configs'
--local util = require 'nvim_lsp/util'
--
--local server_name = "intelephense"
--local bin_name = "intelephense"
--
--local installer = util.npm_installer {
--  server_name = server_name;
--  packages = { "intelephense" };
--  binaries = {bin_name};
--}
--
--configs[server_name] = {
--  default_config = util.utf8_config {
--    cmd = {bin_name, "--stdio"};
--    filetypes = {"php"};
--    root_dir = function (pattern)
--      local cwd  = vim.loop.cwd();
--      local root = util.root_pattern("composer.json", ".git")(pattern);
--
--      -- prefer cwd if root is a descendant
--      return util.path.is_descendant(cwd, root) and cwd or root;
--    end;
--  };
--  on_new_config = function(new_config)
--    local install_info = installer.info()
--    if install_info.is_installed then
--      if type(new_config.cmd) == 'table' then
--        -- Try to preserve any additional args from upstream changes.
--        new_config.cmd[1] = install_info.binaries[bin_name]
--      else
--        new_config.cmd = {install_info.binaries[bin_name]}
--      end
--    end
--  end;
--  docs = {
--    description = [[
--https://intelephense.com/
--
--`intelephense` can be installed via `:LspInstall intelephense` or by yourself with `npm`:
--```sh
--npm install -g intelephense
--```
--]];
--    default_config = {
--      root_dir = [[root_pattern("composer.json", ".git")]];
--      on_init = [[function to handle changing offsetEncoding]];
--      capabilities = [[default capabilities, with offsetEncoding utf-8]];
--      init_options = [[{
--        storagePath = Optional absolute path to storage dir. Defaults to os.tmpdir().
--        globalStoragePath = Optional absolute path to a global storage dir. Defaults to os.homedir().
--        licenceKey = Optional licence key or absolute path to a text file containing the licence key.
--        clearCache = Optional flag to clear server state. State can also be cleared by deleting {storagePath}/intelephense
--        -- See https://github.com/bmewburn/intelephense-docs#initialisation-options
--      }]];
--      settings = [[{
--        intelephense = {
--          files = {
--            maxSize = 1000000;
--          };
--        };
--        -- See https://github.com/bmewburn/intelephense-docs#configuration-options
--      }]];
--    };
--  };
--}
if lspconfig.intelephense then
	require 'lspconfig'.intelephense.setup {
	    --cmd = {bin_name, "--stdio"};
	    filetypes = { "php" },
	    root_dir = function(pattern)
		local cwd = vim.fn.getcwd();
		--local root = util.root_pattern("composer.json", ".git")(pattern);

		-- prefer cwd if root is a descendant
		--return util.path.is_descendant(cwd, root) and cwd or root;
		return cwd
	    end,
	}
end
if lspconfig.jdtls then
	require 'lspconfig'.jdtls.setup {}
end
if lspconfig.cmake then
	require 'lspconfig'.cmake.setup {}
end
if lspconfig.ts_ls then
	require 'lspconfig'.ts_ls.setup {}
end
if lspconfig.cssls then
	require 'lspconfig'.cssls.setup {}
end
if lspconfig.pylsp then
	require 'lspconfig'.pylsp.setup {
	    settings = {
		pylsp = {
		    plugins = {
			jedi = {
			    environment = 'py.exe'
			}
		    }
		}
	    }
	}
end
if lspconfig.gopls then
	require'lspconfig'.gopls.setup{}
end
