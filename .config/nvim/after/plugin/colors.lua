-- this is our single source of truth
local base16_theme_fname = vim.fn.expand(vim.env.HOME .. '/.base16_theme')
local source_dpath = vim.fn.expand(vim.env.HOME .. '/.config/base16-kitty/colors/')
local destination_fname = vim.fn.expand(vim.env.HOME .. '/.config/kitty/current-theme.conf')

-- set theme on start of vim
vim.cmd('colorscheme ' .. vim.fn.readfile(base16_theme_fname)[1])

-- this function is the only way we should be setting our colorscheme
local function set_colorscheme(name)
    -- write our colorscheme back to our single source of truth
    vim.fn.writefile({ name }, base16_theme_fname)
    -- set Neovim's colorscheme
    vim.cmd('colorscheme ' .. name)
    -- execute `kitty @ set-colors -c <color>` to change terminal window's
    -- colors and newly created terminal windows colors
    local cpCommand = "cp " ..
    vim.fn.shellescape(source_dpath) .. name .. ".conf" .. " " .. vim.fn.shellescape(destination_fname)

    -- Execute the cp command
    os.execute(cpCommand)
    -- reload kitty, alternative is ctrl+shift+f5
    os.execute("pkill -USR1 -f kitty")
end


-- then map your function to a key
vim.keymap.set('n', '<leader>c', function()
    -- get our base16 colorschemes
    local colors = vim.fn.getcompletion('base16', 'color')
    -- we're trying to mimic VSCode so we'll use dropdown theme
    local theme = require('telescope.themes').get_dropdown()
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    -- create our picker
    require('telescope.pickers').new(theme, {
        prompt = 'Change Base16 Colorscheme',
        finder = require('telescope.finders').new_table {
            results = colors
        },
        sorter = require('telescope.config').values.generic_sorter(theme),
        attach_mappings = function(bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                set_colorscheme(selection.value)
                actions.close(bufnr)
            end)
            map('i', '<C-n>', function()
                actions.move_selection_next(bufnr)
                set_colorscheme(action_state.get_selected_entry().value)
            end)
            map('i', '<C-p>', function()
                actions.move_selection_previous(bufnr)
                set_colorscheme(action_state.get_selected_entry().value)
            end)
            return true
        end
    }):find()
end)
