-- NEVERLOSE UI - Main Interface
-- 1:1 Replica Implementation
-- Modular architecture with component-based rendering
-- GitHub flat structure version

local ui = {}

-- Dependencies (flat structure - no ui/ prefix)
local renderer = require("renderer")
local theme = require("theme")
local navigation = require("navigation")
local topbar = require("topbar")
local ragebot_page = require("ragebot")
local placeholder_page = require("placeholder")

-- UI State
local is_open = true
local screen_width = 1920
local screen_height = 1080

-- Page registry
local pages = {
    ragebot = ragebot_page,
    antiaim = placeholder_page,
    legitbot = placeholder_page,
    players = placeholder_page,
    world = placeholder_page,
    inventory = placeholder_page,
    main = placeholder_page,
    scripts = placeholder_page,
    configs = placeholder_page,
}

-- Initialize UI
function ui.init(width, height)
    screen_width = width or 1920
    screen_height = height or 1080
    
    renderer.set_screen_size(screen_width, screen_height)
    
    print("[NEVERLOSE] UI Initialized")
    print("[NEVERLOSE] Screen: " .. screen_width .. "x" .. screen_height)
end

-- Set UI visibility
function ui.set_open(open)
    is_open = open
end

function ui.is_open()
    return is_open
end

-- Handle input (called from your input system)
function ui.handle_input(mouse_x, mouse_y, mouse_down, mouse_clicked)
    if not is_open then return end
    
    -- Update component input state
    local components = require("components")
    components.set_input_state(mouse_x, mouse_y, mouse_down, mouse_clicked)
    
    -- Handle navigation clicks
    if mouse_clicked then
        if navigation.handle_click(mouse_x, mouse_y) then
            -- Page changed
            return true
        end
    end
    
    return false
end

-- Main Render Function
function ui.render()
    if not is_open then return end
    
    -- Main background
    renderer.draw_rect(0, 0, screen_width, screen_height, theme.colors.bg_dark)
    
    -- Render top bar
    topbar.render(screen_width)
    
    -- Render navigation pane
    navigation.render(screen_width, screen_height)
    
    -- Get current page
    local current_page = navigation.get_current_page()
    local page_module = pages[current_page]
    
    if page_module then
        -- Calculate content area
        local nav_width = theme.dimensions.nav_width
        local topbar_height = theme.dimensions.topbar_height
        local content_x = nav_width + 20
        local content_y = topbar_height + 20
        local content_width = screen_width - nav_width - 40
        
        -- Render current page
        if current_page == "ragebot" then
            page_module.render(content_x, content_y, content_width)
        else
            page_module.render(content_x, content_y, content_width, current_page)
        end
    end
    
    -- Bottom right branding
    renderer.draw_text("REVUNITY.COM", screen_width - 120, screen_height - 25, theme.colors.text_disabled, theme.font_sizes.small, theme.fonts.regular)
end

-- Get page settings
function ui.get_page_settings(page_name)
    page_name = page_name or navigation.get_current_page()
    local page_module = pages[page_name]
    
    if page_module and page_module.get_settings then
        return page_module.get_settings()
    end
    
    return {}
end

-- Set page settings
function ui.set_page_settings(page_name, settings)
    page_name = page_name or navigation.get_current_page()
    local page_module = pages[page_name]
    
    if page_module and page_module.set_settings then
        page_module.set_settings(settings)
        return true
    end
    
    return false
end

-- Get current page name
function ui.get_current_page()
    return navigation.get_current_page()
end

-- Set config dropdown
function ui.set_config(name)
    topbar.set_config(name)
end

-- Get config dropdown
function ui.get_config()
    return topbar.get_config()
end

-- Export renderer for external use if needed
ui.renderer = renderer
ui.theme = theme

return ui

