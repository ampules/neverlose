-- NEVERLOSE UI Renderer
-- Handles all drawing operations

local renderer = {}

-- Screen dimensions (will be set externally)
local screen_width = 1920
local screen_height = 1080

function renderer.set_screen_size(width, height)
    screen_width = width
    screen_height = height
end

function renderer.get_screen_size()
    return screen_width, screen_height
end

-- Drawing Functions
-- These would be implemented based on your Lua GUI framework

function renderer.draw_rect(x, y, width, height, color)
    -- Implementation depends on your framework
    -- Example: draw.filled_rect(x, y, width, height, color)
    -- color format: {r, g, b, a} (0-255)
end

function renderer.draw_rect_outline(x, y, width, height, thickness, color)
    -- Draw outline rectangle
    -- Example: draw.rect(x, y, width, height, thickness, color)
end

function renderer.draw_text(text, x, y, color, size, font)
    -- Render text
    -- Example: draw.text(text, x, y, color, size, font)
    -- font: "regular", "bold", "light"
end

function renderer.draw_line(x1, y1, x2, y2, color, thickness)
    -- Draw a line
    -- Example: draw.line(x1, y1, x2, y2, color, thickness)
end

function renderer.draw_circle(x, y, radius, color, filled)
    -- Draw a circle
    -- Example: draw.circle(x, y, radius, color, filled)
end

function renderer.draw_triangle(x1, y1, x2, y2, x3, y3, color, filled)
    -- Draw a triangle
end

function renderer.get_text_size(text, size, font)
    -- Get text dimensions
    -- Returns: width, height
    return 100, 20 -- Placeholder
end

function renderer.is_point_in_rect(px, py, x, y, width, height)
    return px >= x and px <= x + width and py >= y and py <= y + height
end

-- Color utilities
function renderer.color(r, g, b, a)
    a = a or 255
    return {r, g, b, a}
end

function renderer.color_alpha(color, alpha)
    return {color[1], color[2], color[3], alpha}
end

-- Icon rendering placeholder
function renderer.draw_icon(icon_name, x, y, width, height, color)
    color = color or {255, 255, 255, 255}
    -- Icon rendering would go here
    -- This would load and draw SVG or bitmap icons
end

return renderer

