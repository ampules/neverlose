-- NEVERLOSE UI - Navigation Pane
-- Left sidebar navigation

local navigation = {}
local renderer = require("ui/renderer")
local theme = require("ui/theme")
local components = require("ui/components")

-- Navigation structure
local nav_items = {
    {
        category = "Aimbot",
        items = {
            { name = "Ragebot", icon = "gear", page = "ragebot" },
            { name = "Anti Aim", icon = "refresh", page = "antiaim" },
            { name = "Legitbot", icon = "mouse", page = "legitbot" }
        }
    },
    {
        category = "Visuals",
        items = {
            { name = "Players", icon = "person", page = "players" },
            { name = "World", icon = "globe", page = "world" },
            { name = "Inventory", icon = "bag", page = "inventory" }
        }
    },
    {
        category = "Miscellaneous",
        items = {
            { name = "Main", icon = "wrench", page = "main" },
            { name = "Scripts", icon = "code", page = "scripts" },
            { name = "Configs", icon = "gear", page = "configs" }
        }
    }
}

local current_page = "ragebot"

function navigation.get_current_page()
    return current_page
end

function navigation.set_current_page(page)
    current_page = page
end

function navigation.render(screen_width, screen_height)
    local nav_width = theme.dimensions.nav_width
    local topbar_height = theme.dimensions.topbar_height
    
    -- Navigation background
    renderer.draw_rect(0, topbar_height, nav_width, screen_height - topbar_height, theme.colors.bg_nav)
    
    local y_offset = topbar_height + 20
    
    -- Render categories and items
    for _, category in ipairs(nav_items) do
        -- Category header
        renderer.draw_text(category.category, 20, y_offset, theme.colors.text_category, theme.font_sizes.small, theme.fonts.regular)
        y_offset = y_offset + 30
        
        -- Category items
        for _, item in ipairs(category.items) do
            local is_selected = (item.page == current_page)
            
            -- Selected item background
            if is_selected then
                renderer.draw_rect(10, y_offset - 5, nav_width - 20, 30, theme.colors.accent_selected)
            end
            
            -- Icon (placeholder)
            local icon_x = 20
            -- renderer.draw_icon(item.icon, icon_x, y_offset, 16, 16, is_selected and theme.colors.text_primary or theme.colors.text_secondary)
            
            -- Item text
            renderer.draw_text(item.name, icon_x + 25, y_offset, 
                is_selected and theme.colors.text_primary or theme.colors.text_secondary, 
                theme.font_sizes.medium, 
                is_selected and theme.fonts.bold or theme.fonts.regular)
            
            -- Click detection
            local item_rect = {x = 10, y = y_offset - 5, width = nav_width - 20, height = 30}
            -- This would be handled by input system
            
            y_offset = y_offset + 35
        end
        
        y_offset = y_offset + 10
    end
    
    -- Bottom branding
    local bottom_y = screen_height - 50
    renderer.draw_text("R", 20, bottom_y, theme.colors.accent_primary, theme.font_sizes.large, theme.fonts.bold)
    renderer.draw_text("ReemoCheats", 35, bottom_y, theme.colors.text_secondary, theme.font_sizes.small, theme.fonts.regular)
    
    -- Timestamp
    local timestamp = os.date("Ttl: %m.%d %H:%M")
    renderer.draw_text(timestamp, 20, bottom_y + 18, theme.colors.text_disabled, theme.font_sizes.small, theme.fonts.regular)
end

function navigation.handle_click(x, y)
    local nav_width = theme.dimensions.nav_width
    local topbar_height = theme.dimensions.topbar_height
    
    if x < nav_width and y > topbar_height then
        local y_offset = topbar_height + 20
        
        for _, category in ipairs(nav_items) do
            y_offset = y_offset + 30
            
            for _, item in ipairs(category.items) do
                local item_y = y_offset - 5
                local item_height = 30
                
                if y >= item_y and y <= item_y + item_height then
                    current_page = item.page
                    return true
                end
                
                y_offset = y_offset + 35
            end
            
            y_offset = y_offset + 10
        end
    end
    
    return false
end

return navigation

