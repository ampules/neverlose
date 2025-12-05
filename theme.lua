-- NEVERLOSE UI Theme Configuration
-- Exact color scheme and styling

local theme = {}

-- Color Palette
theme.colors = {
    -- Backgrounds
    bg_dark = {18, 18, 23, 255},           -- Main background
    bg_nav = {25, 25, 35, 255},            -- Navigation sidebar
    bg_section = {30, 30, 40, 255},        -- Section containers
    bg_topbar = {35, 35, 45, 255},         -- Top bar
    bg_dropdown = {18, 18, 23, 255},       -- Dropdown background
    
    -- Accent Colors (Blue theme)
    accent_primary = {100, 150, 255, 255},  -- Primary blue
    accent_hover = {120, 170, 255, 255},    -- Hover state
    accent_selected = {80, 130, 255, 255},  -- Selected item
    accent_active = {100, 150, 255, 255},   -- Active toggle/slider
    
    -- Text Colors
    text_primary = {255, 255, 255, 255},    -- Main text
    text_secondary = {180, 180, 180, 255},  -- Secondary text
    text_disabled = {100, 100, 100, 255},   -- Disabled text
    text_category = {180, 180, 180, 255},   -- Category headers
    
    -- Borders and Lines
    border = {50, 50, 60, 255},             -- Default border
    border_hover = {70, 70, 80, 255},       -- Hover border
    
    -- Interactive Elements
    toggle_inactive = {50, 50, 60, 255},    -- Inactive toggle
    slider_track = {50, 50, 60, 255},       -- Slider track
    slider_fill = {100, 150, 255, 255},     -- Slider fill
    
    -- Shadows and Overlays
    shadow = {0, 0, 0, 150},                -- Shadow overlay
    overlay = {0, 0, 0, 200},               -- Modal overlay
}

-- Typography
theme.fonts = {
    regular = "regular",      -- Regular weight font
    bold = "bold",            -- Bold weight font
    light = "light",          -- Light weight font
}

theme.font_sizes = {
    small = 10,
    regular = 12,
    medium = 13,
    large = 14,
    title = 16,
}

-- Spacing and Dimensions
theme.spacing = {
    xs = 5,
    sm = 10,
    md = 15,
    lg = 20,
    xl = 30,
}

theme.dimensions = {
    nav_width = 200,
    topbar_height = 45,
    section_padding = 15,
    section_spacing = 10,
    item_spacing = 35,
    toggle_width = 45,
    toggle_height = 20,
    slider_height = 5,
    slider_handle_size = 12,
    dropdown_height = 30,
    icon_size = 16,
    icon_size_large = 20,
}

-- Border Radius
theme.border_radius = {
    small = 2,
    medium = 4,
    large = 6,
}

-- Animations (in milliseconds)
theme.animations = {
    fast = 150,
    medium = 250,
    slow = 350,
}

-- Helper Functions
function theme.color(r, g, b, a)
    a = a or 255
    return {r, g, b, a}
end

function theme.color_alpha(color, alpha)
    return {color[1], color[2], color[3], alpha}
end

function theme.lerp_color(color1, color2, t)
    t = math.max(0, math.min(1, t))
    return {
        math.floor(color1[1] + (color2[1] - color1[1]) * t),
        math.floor(color1[2] + (color2[2] - color1[2]) * t),
        math.floor(color1[3] + (color2[3] - color1[3]) * t),
        math.floor(color1[4] + (color2[4] - color1[4]) * t),
    }
end

return theme

