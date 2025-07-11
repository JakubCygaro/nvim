local M = {}

local orig_diag_virt_handler = vim.diagnostic.handlers.virtual_text
local orig_diag_signs_handler = vim.diagnostic.handlers.signs
local ns = vim.api.nvim_create_namespace("my_diagnostics")

local filter_diagnostics = function(diagnostics, level)
    local filtered_diag = {}
    for _, d in ipairs(diagnostics) do
        if d.severity <= level then
            table.insert(filtered_diag, 1, d)
        end
    end
    return filtered_diag
end

M.set_level = function(level)
    -- hide all diagnostics
    vim.diagnostic.hide(nil, 0)

    -- vim.diagnostic.reset()
    vim.diagnostic.handlers.virtual_text = {
        show = function(_, bufnr, _, opts)
            -- get all diagnostics for local buffer
            local diagnostics = vim.diagnostic.get(bufnr)
            filtered = filter_diagnostics(diagnostics, level)
            -- filter diags based on severity
            orig_diag_virt_handler.show(ns, bufnr, filtered, opts)
        end,
        hide = function(_, bufnr)
            orig_diag_virt_handler.hide(ns, bufnr)
        end
    }
    vim.diagnostic.handlers.signs = {
        show = function(_, bufnr, _, opts)
            -- get all diagnostics for local buffer
            local diagnostics = vim.diagnostic.get(bufnr)
            filtered = filter_diagnostics(diagnostics, level)
            -- filter diags based on severity
            orig_diag_signs_handler.show(ns, bufnr, filtered, opts)
        end,
        hide = function(_, bufnr)
            orig_diag_signs_handler.hide(ns, bufnr)
        end
    }

    bufnr = vim.api.nvim_get_current_buf()
    local diags = vim.diagnostic.get(bufnr)
    if #diags > 0 then
        filtered = filter_diagnostics(diags, level)
        vim.diagnostic.show(ns, bufnr, filtered)
    end
end

return M
