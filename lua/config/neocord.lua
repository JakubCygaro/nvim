require("neocord").setup({
    -- General options
    logo                = "auto",
    logo_tooltip        = nil,
    main_image          = "logo",
    log_level           = nil,
    debounce_timeout    = 10,
    blacklist           = {},
    file_assets         = {},
    show_time           = true,
    global_timer        = false,

    -- Rich Presence text options
    editing_text        = "Editing text",
    file_explorer_text  = "Exploring files",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading",
    workspace_text      = "Working on repo",
    line_number_text    = "Line %s out of %s",
    terminal_text       = "Using Terminal",
})
