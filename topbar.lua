-- NEVERLOSE UI - Top Bar
-- Top navigation bar

local topbar = {}
local renderer = require("ui/renderer")
local theme = require("ui/theme")
local components = require("ui/components")

local config_dropdown = "Global"
local config_dropdown_open = false

function topbar.render(screen_width)
    local height = theme.dimensions.topbar_height
    
    -- Top bar background
    renderer.draw_rect(0, 0, screen_width, height, theme.colors.bg_topbar)
    
    -- Save button (floppy disk icon)
    local save_x = 20
    local save_y = 12
    -- renderer.draw_icon("floppy", save_x, save_y, 20, 20, theme.colors.text_primary)
    renderer.draw_text("Save", save_x + 25, save_y, theme.colors.text_primary, theme.font_sizes.medium, theme.fonts.regular)
    
    -- Global dropdown
    local dropdown_x = 150
    local dropdown_width = 120
    local dropdown_height = 25
    
    -- Dropdown hover detection (mouse_x, mouse_y would be passed from input system)
    -- local dropdown_hovered = renderer.is_point_in_rect(mouse_x, mouse_y, dropdown_x, save_y, dropdown_width, dropdown_height)
    local dropdown_hovered = false
    local dropdown_bg = dropdown_hovered and theme.colors.bg_section or theme.colors.bg_dark
    
    renderer.draw_rect(dropdown_x, save_y, dropdown_width, dropdown_height, dropdown_bg)
    renderer.draw_rect_outline(dropdown_x, save_y, dropdown_width, dropdown_height, 1, theme.colors.border)
    
    renderer.draw_text(config_dropdown, dropdown_x + 10, save_y + 5, theme.colors.text_primary, theme.font_sizes.medium, theme.fonts.regular)
    
    -- Dropdown arrow
    local arrow_x = dropdown_x + dropdown_width - 20
    local arrow_y = save_y + 10
    renderer.draw_triangle(
        arrow_x, arrow_y,
        arrow_x + 8, arrow_y,
        arrow_x + 4, arrow_y + 6,
        theme.colors.text_primary,
        true
    )
    
    -- Right side icons
    local icon_size = theme.dimensions.icon_size_large
    local icon_spacing = 30
    local icons_start_x = screen_width - 120
    
    -- Chat bubble icon
    -- renderer.draw_icon("chat", icons_start_x, save_y, icon_size, icon_size, theme.colors.text_secondary)
    
    -- Gear icon
    -- renderer.draw_icon("gear", icons_start_x + icon_spacing, save_y, icon_size, icon_size, theme.colors.text_secondary)
    
    -- Power button icon
    -- renderer.draw_icon("power", icons_start_x + icon_spacing * 2, save_y, icon_size, icon_size, theme.colors.text_secondary)
end

function topbar.set_config(name)
    config_dropdown = name
end

function topbar.get_config()
    return config_dropdown
end

return topbar

