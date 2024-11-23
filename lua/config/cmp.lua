local cmp = require('cmp')

cmp.setup({
  -- completion = {
  --   autocomplete = false
  -- },
  sources = {
    {name = 'nvim_lsp'},
    -- {name = 'buffer'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    --['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping.confirm({select = true}),
    -- scroll up and down the documentation window
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4), 
    -- Simple tab complete
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   local col = vim.fn.col('.') - 1

    --   if cmp.visible() then
    --     cmp.select_next_item({behavior = 'select'})
    --   elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    --     fallback()
    --   else
    --     cmp.complete()
    --   end
    -- end, {'i', 's'}),

    -- -- Go to previous item
    -- ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
  }),
})
