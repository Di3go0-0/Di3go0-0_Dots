return {
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            {
                "<leader>gg",
                "<cmd>LazyGit<cr>",
                desc = "LazyGit",
            },
        },
        config = function()
            vim.g.lazygit_floating_window_winblend = 0 -- transparencia (0 es opaco)
            vim.g.lazygit_floating_window_scaling_factor = 1.0 -- ocupa el 100% del espacio
            vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" } -- sin bordes para que parezca full screen
            vim.g.lazygit_use_neovim_remote = 1 -- opcional, mejora la integración
        end,
    },
}
