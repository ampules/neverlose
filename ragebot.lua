-- NEVERLOSE UI - Ragebot Page
-- Main aimbot configuration page

local ragebot_page = {}
local components = require("ui/components")
local theme = require("ui/theme")

-- Page state
local page_settings = {
    -- Main section
    enabled = false,
    peek_assist = false,
    hide_shots = false,
    double_tap = false,
    field_of_view = 0,
    
    -- Accuracy section
    auto_scope = false,
    auto_stop = false,
    
    -- Selection section
    hitboxes = {"Head", "Stomach"},
    multipoint = {"Head", "Stomach"},
    hit_chance = 0,
    minimum_damage = "Auto",
    penetrate_walls = true,
    
    -- Safety section
    body_aim = "Default",
    safe_points = "Default",
    ensure_hitbox_safety = "Select",
}

function ragebot_page.get_settings()
    return page_settings
end

function ragebot_page.set_settings(new_settings)
    for key, value in pairs(new_settings) do
        page_settings[key] = value
    end
end

function ragebot_page.render(content_x, content_y, content_width)
    local spacing = theme.dimensions.section_spacing
    local section_width = (content_width - spacing) / 2
    local section_height = 300
    
    -- Top row: Main and Selection sections
    local main_area = components.section("Main", content_x, content_y, section_width, section_height)
    render_main_section(main_area.x, main_area.y, main_area.width, main_area.height)
    
    local selection_area = components.section("Selection", content_x + section_width + spacing, content_y, section_width, section_height)
    render_selection_section(selection_area.x, selection_area.y, selection_area.width, selection_area.height)
    
    -- Bottom row: Accuracy and Safety sections
    local accuracy_area = components.section("Accuracy", content_x, content_y + section_height + spacing, section_width, section_height)
    render_accuracy_section(accuracy_area.x, accuracy_area.y, accuracy_area.width, accuracy_area.height)
    
    local safety_area = components.section("Safety", content_x + section_width + spacing, content_y + section_height + spacing, section_width, section_height)
    render_safety_section(safety_area.x, safety_area.y, safety_area.width, safety_area.height)
end

-- Main Section
function render_main_section(x, y, width, height)
    local item_y = y
    local item_spacing = theme.dimensions.item_spacing
    
    -- Enabled toggle
    page_settings.enabled = components.toggle("Enabled", x, item_y, page_settings.enabled, function(val)
        page_settings.enabled = val
    end)
    item_y = item_y + item_spacing
    
    -- Peek Assist toggle
    page_settings.peek_assist = components.toggle("Peek Assist", x, item_y, page_settings.peek_assist, function(val)
        page_settings.peek_assist = val
    end)
    item_y = item_y + item_spacing
    
    -- Hide Shots toggle
    page_settings.hide_shots = components.toggle("Hide Shots", x, item_y, page_settings.hide_shots, function(val)
        page_settings.hide_shots = val
    end)
    item_y = item_y + item_spacing
    
    -- Double Tap toggle
    page_settings.double_tap = components.toggle("Double Tap", x, item_y, page_settings.double_tap, function(val)
        page_settings.double_tap = val
    end)
    item_y = item_y + item_spacing
    
    -- Field of View slider
    page_settings.field_of_view = components.slider("Field of View", x, item_y, width, page_settings.field_of_view, 0, 100, function(val)
        page_settings.field_of_view = val
    end)
end

-- Accuracy Section
function render_accuracy_section(x, y, width, height)
    local item_y = y
    local item_spacing = theme.dimensions.item_spacing
    
    -- Auto Scope toggle
    page_settings.auto_scope = components.toggle("Auto Scope", x, item_y, page_settings.auto_scope, function(val)
        page_settings.auto_scope = val
    end)
    item_y = item_y + item_spacing
    
    -- Auto Stop toggle
    page_settings.auto_stop = components.toggle("Auto Stop", x, item_y, page_settings.auto_stop, function(val)
        page_settings.auto_stop = val
    end)
end

-- Selection Section
function render_selection_section(x, y, width, height)
    local item_y = y
    local item_spacing = theme.dimensions.item_spacing
    
    -- Hitboxes dropdown
    page_settings.hitboxes = components.dropdown("Hitboxes", x, item_y, width, page_settings.hitboxes, {
        {"Head", "Stomach"},
        {"Head", "Chest", "Stomach"},
        {"Head"},
        {"All"}
    }, function()
        -- Dropdown menu logic
    end)
    item_y = item_y + item_spacing
    
    -- Multipoint dropdown
    page_settings.multipoint = components.dropdown("Multipoint", x, item_y, width, page_settings.multipoint, {
        {"Head", "Stomach"},
        {"Head", "Chest", "Stomach"},
        {"Head"},
        {"All"}
    }, function()
        -- Dropdown menu logic
    end)
    item_y = item_y + item_spacing
    
    -- Hit Chance slider
    page_settings.hit_chance = components.slider("Hit Chance", x, item_y, width, page_settings.hit_chance, 0, 100, function(val)
        page_settings.hit_chance = val
    end)
    item_y = item_y + item_spacing
    
    -- Minimum Damage slider with "Auto" label
    local min_damage_val = page_settings.minimum_damage == "Auto" and 0 or tonumber(page_settings.minimum_damage) or 0
    min_damage_val = components.slider("Minimum Damage", x, item_y, width, min_damage_val, 0, 100, function(val)
        if val == 0 then
            page_settings.minimum_damage = "Auto"
        else
            page_settings.minimum_damage = tostring(math.floor(val))
        end
    end, page_settings.minimum_damage == "Auto" and "Auto" or nil)
    item_y = item_y + item_spacing
    
    -- Penetrate Walls toggle
    page_settings.penetrate_walls = components.toggle("Penetrate Walls", x, item_y, page_settings.penetrate_walls, function(val)
        page_settings.penetrate_walls = val
    end)
end

-- Safety Section
function render_safety_section(x, y, width, height)
    local item_y = y
    local item_spacing = theme.dimensions.item_spacing
    
    -- Body Aim dropdown
    page_settings.body_aim = components.dropdown("Body Aim", x, item_y, width, page_settings.body_aim, {
        "Default",
        "Prefer Head",
        "Prefer Body",
        "Force Head",
        "Force Body"
    }, function()
        -- Dropdown menu logic
    end)
    item_y = item_y + item_spacing
    
    -- Safe Points dropdown
    page_settings.safe_points = components.dropdown("Safe Points", x, item_y, width, page_settings.safe_points, {
        "Default",
        "Low",
        "Medium",
        "High",
        "Maximum"
    }, function()
        -- Dropdown menu logic
    end)
    item_y = item_y + item_spacing
    
    -- Ensure Hitbox Safety dropdown
    page_settings.ensure_hitbox_safety = components.dropdown("Ensure Hitbox Safety", x, item_y, width, page_settings.ensure_hitbox_safety, {
        "Select",
        "Enabled",
        "Disabled"
    }, function()
        -- Dropdown menu logic
    end)
end

return ragebot_page

