return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        "BufReadPre " .. vim.fn.expand("~") .. "/Documents/notes/**.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Documents/notes/**.md",
    },
    cmd = {
        "ObsidianOpen", "ObsidianSearch", "ObsidianWorkspace"
    },
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required.
    },
    config = function()
        require("obsidian").setup({
            workspaces = {
                {
                    name = "notes",
                    path = "~/Documents/notes",
                },
            },
            detect_cwd = false,
            mappings = {
                -- Toggle check-boxes.
                ["<leader>t"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
            },
            finder = "telescope.nvim",
            finder_mappings = {
                new = "<C-x>",
            },
            notes_subdir = ".newnotes",
            completion = {
                nvim_cmp = true,
                min_chars = 2,
                new_notes_location = "notes_subdir",
                prepend_note_id = true,
                prepend_note_path = false,
                use_path_only = false,
            },
        })

        vim.keymap.set("n", "gf", function()
            if require("obsidian").util.cursor_on_markdown_link() then
                return "<cmd>ObsidianFollowLink<CR>"
            else
                return "gf"
            end
        end, { noremap = false, expr = true, buffer = true })
    end,

}
