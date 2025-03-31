local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  -- completion = {
  --   autocomplete = false
  -- },
  formatting = {
    format = lspkind.cmp_format({
      --with_text = true, -- do not show text alongside icons
      mode = 'symbol_text',
      maxwidth = 45, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- preset = 'default',
      ellipsis_char = '...',
      symbol_map = {
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Keyword = "",
        Module = "",
        Method = "",
        Operator = "",
        Property = "",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "V",
        Variable = "",
      },
    })
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping({
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({select = true}), { "i" }),
    -- scroll up and down the documentation window
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    -- select items from suggestion window
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    --abort completion
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),
  }),
})
