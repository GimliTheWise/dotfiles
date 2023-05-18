-- All builtin colorschemes can be accessed with |:colorscheme|.
vim.cmd('colorscheme base16-gruvbox-dark-soft')

-- Alternatively, you can provide a table specifying your colors to the setup function.
require('base16-colorscheme').setup({
    base00 = '#16161D', base01 = '#2c313c', base02 = '#3e4451', base03 = '#6c7891',
    base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
    base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
    base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
})



-- this is our single source of truth created above
local base16_theme_fname = vim.fn.expand(vim.env.HOME..'/.config/.base16_theme')
-- this function is the only way we should be setting our colorscheme
local function set_colorscheme(name)
    -- write our colorscheme back to our single source of truth
    vim.fn.writefile({name}, base16_theme_fname)
    -- set Neovim's colorscheme
    vim.cmd('colorscheme '..name)
    -- execute `kitty @ set-colors -c <color>` to change terminal window's
    -- colors and newly created terminal windows colors
    vim.loop.spawn('kitty', {
        args = {
            '@',
            'set-colors',
            '-c',
            string.format(vim.env.HOME..'/.config/base16-kitty/colors/%s.conf', name)
        }
    }, nil)
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
