-- NEVERLOSE UI Components
-- Reusable UI components

local components = {}
local renderer = require("ui/renderer")

-- Input state (would be provided by your framework)
local mouse_x = 0
local mouse_y = 0
local mouse_down = false
local mouse_clicked = false

function components.set_input_state(x, y, down, clicked)
    mouse_x = x
    mouse_y = y
    mouse_down = down
    mouse_clicked = clicked
end

-- Toggle Switch Component
function components.toggle(label, x, y, value, callback, show_gear)
    show_gear = show_gear ~= false -- Default to true
    
    local theme = {
        bg_active = {100, 150, 255, 255},
        bg_inactive = {50, 50, 60, 255},
        indicator = {255, 255, 255, 255},
        text = {255, 255, 255, 255}
    }
    
    -- Label
    renderer.draw_text(label, x, y, theme.text, 13, "regular")
    
    -- Toggle switch dimensions
    local toggle_width = 45
    local toggle_height = 20
    local toggle_x = x + 200
    local toggle_y = y
    
    -- Check if hovered
    local hovered = renderer.is_point_in_rect(mouse_x, mouse_y, toggle_x, toggle_y, toggle_width, toggle_height)
    
    -- Toggle background
    local bg_color = value and theme.bg_active or theme.bg_inactive
    if hovered then
        bg_color = value and {120, 170, 255, 255} or {70, 70, 80, 255}
    end
    renderer.draw_rect(toggle_x, toggle_y, toggle_width, toggle_height, bg_color)
    
    -- Toggle indicator (circle)
    local indicator_size = 14
    local indicator_offset = 3
    local indicator_x = value and (toggle_x + toggle_width - indicator_size - indicator_offset) or (toggle_x + indicator_offset)
    local indicator_y = toggle_y + (toggle_height - indicator_size) / 2
    renderer.draw_circle(indicator_x + indicator_size/2, indicator_y + indicator_size/2, indicator_size/2, theme.indicator, true)
    
    -- Gear icon
    if show_gear then
        local gear_x = toggle_x + toggle_width + 10
        local gear_y = toggle_y + 2
        renderer.draw_icon("gear", gear_x, gear_y, 16, 16, {180, 180, 180, 255})
    end
    
    -- Handle click
    if mouse_clicked and hovered then
        if callback then
            callback(not value)
        end
        return not value
    end
    
    return value
end

-- Slider Component
function components.slider(label, x, y, width, value, min, max, callback, extra_label)
    local theme = {
        track = {50, 50, 60, 255},
        fill = {100, 150, 255, 255},
        handle = {100, 150, 255, 255},
        text = {255, 255, 255, 255},
        text_secondary = {180, 180, 180, 255}
    }
    
    -- Label
    renderer.draw_text(label, x, y, theme.text, 13, "regular")
    
    -- Slider track
    local slider_height = 5
    local slider_y = y + 20
    renderer.draw_rect(x, slider_y, width, slider_height, theme.track)
    
    -- Calculate fill width
    local normalized_value = math.max(0, math.min(1, (value - min) / (max - min)))
    local fill_width = normalized_value * width
    renderer.draw_rect(x, slider_y, fill_width, slider_height, theme.fill)
    
    -- Slider handle
    local handle_size = 12
    local handle_x = x + fill_width - (handle_size / 2)
    local handle_y = slider_y - (handle_size - slider_height) / 2
    
    -- Check if dragging
    local handle_rect = {
        x = handle_x,
        y = handle_y,
        width = handle_size,
        height = handle_size
    }
    
    local hovered = renderer.is_point_in_rect(mouse_x, mouse_y, handle_x, handle_y, handle_size, handle_size)
    local track_hovered = renderer.is_point_in_rect(mouse_x, mouse_y, x, slider_y, width, slider_height)
    
    -- Handle drag
    if mouse_down and (hovered or track_hovered) then
        local new_value = min + ((mouse_x - x) / width) * (max - min)
        new_value = math.max(min, math.min(max, new_value))
        if callback then
            callback(new_value)
        end
    end
    
    -- Draw handle
    local handle_color = (hovered or (mouse_down and track_hovered)) and {120, 170, 255, 255} or theme.handle
    renderer.draw_circle(handle_x + handle_size/2, handle_y + handle_size/2, handle_size/2, handle_color, true)
    
    -- Value display
    local value_text = extra_label or tostring(math.floor(value))
    renderer.draw_text(value_text, x + width + 10, y, theme.text_secondary, 12, "regular")
    
    -- Gear icon
    local gear_x = x + width + 80
    renderer.draw_icon("gear", gear_x, y, 16, 16, {180, 180, 180, 255})
    
    return value
end

-- Dropdown Component
function components.dropdown(label, x, y, width, current_value, options, callback, show_gear)
    show_gear = show_gear ~= false -- Default to true
    options = options or {}
    
    local theme = {
        bg = {18, 18, 23, 255},
        border = {50, 50, 60, 255},
        text = {255, 255, 255, 255},
        hover = {40, 40, 50, 255}
    }
    
    -- Label
    renderer.draw_text(label, x, y, theme.text, 13, "regular")
    
    -- Dropdown background
    local dropdown_height = 30
    local dropdown_y = y + 20
    local hovered = renderer.is_point_in_rect(mouse_x, mouse_y, x, dropdown_y, width, dropdown_height)
    
    local bg_color = hovered and theme.hover or theme.bg
    renderer.draw_rect(x, dropdown_y, width, dropdown_height, bg_color)
    renderer.draw_rect_outline(x, dropdown_y, width, dropdown_height, 1, theme.border)
    
    -- Current value text
    local value_text = type(current_value) == "table" and table.concat(current_value, ", ") or tostring(current_value)
    renderer.draw_text(value_text, x + 10, dropdown_y + 8, theme.text, 12, "regular")
    
    -- Dropdown arrow
    local arrow_x = x + width - 25
    local arrow_y = dropdown_y + 5
    -- Draw triangle pointing down
    renderer.draw_triangle(
        arrow_x, arrow_y + 5,
        arrow_x + 10, arrow_y + 5,
        arrow_x + 5, arrow_y + 15,
        theme.text,
        true
    )
    
    -- Gear icon
    if show_gear then
        local gear_x = x + width + 10
        local gear_y = dropdown_y + 7
        renderer.draw_icon("gear", gear_x, gear_y, 16, 16, {180, 180, 180, 255})
    end
    
    -- Handle click (would open dropdown menu)
    if mouse_clicked and hovered and callback then
        callback()
    end
    
    return current_value
end

-- Button Component
function components.button(label, x, y, width, height, callback)
    local theme = {
        bg = {100, 150, 255, 255},
        hover = {120, 170, 255, 255},
        text = {255, 255, 255, 255}
    }
    
    local hovered = renderer.is_point_in_rect(mouse_x, mouse_y, x, y, width, height)
    local bg_color = hovered and theme.hover or theme.bg
    
    renderer.draw_rect(x, y, width, height, bg_color)
    
    -- Center text
    local text_width, text_height = renderer.get_text_size(label, 13, "regular")
    local text_x = x + (width - text_width) / 2
    local text_y = y + (height - text_height) / 2
    
    renderer.draw_text(label, text_x, text_y, theme.text, 13, "regular")
    
    -- Handle click
    if mouse_clicked and hovered and callback then
        callback()
        return true
    end
    
    return false
end

-- Section Container Component
function components.section(title, x, y, width, height)
    local theme = {
        bg = {30, 30, 40, 255},
        border = {50, 50, 60, 255},
        text = {255, 255, 255, 255}
    }
    
    -- Section background
    renderer.draw_rect(x, y, width, height, theme.bg)
    renderer.draw_rect_outline(x, y, width, height, 1, theme.border)
    
    -- Section title
    renderer.draw_text(title, x + 15, y + 15, theme.text, 14, "bold")
    
    -- Return content area bounds
    return {
        x = x + 15,
        y = y + 45,
        width = width - 30,
        height = height - 60
    }
end

return components

