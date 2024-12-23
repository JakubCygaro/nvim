local lsp_status_provider = nil;

local lsp_status = require'lsp-status';

lsp_status_provider = function ()
    local status = lsp_status.status();
    return status;
end

return lsp_status_provider;
