-- NEVERLOSE UI - Module Loader for Roblox
-- Loads modules from GitHub raw URLs

local HttpService = game:GetService("HttpService")

-- Configuration: Set your GitHub repository URL here
local BASE_URL = "https://raw.githubusercontent.com/ampules/neverlose/refs/heads/main/"

-- Module cache
local MODULE_CACHE = {}

-- Create a custom require function
local function loadModule(moduleName)
    -- Check cache first
    if MODULE_CACHE[moduleName] then
        return MODULE_CACHE[moduleName]
    end
    
    -- Construct URL
    local url = BASE_URL .. moduleName .. ".lua"
    
    -- Fetch module from GitHub
    local success, result = pcall(function()
        return HttpService:GetAsync(url)
    end)
    
    if not success then
        warn("[Loader] Failed to load module: " .. moduleName)
        warn("[Loader] URL: " .. url)
        warn("[Loader] Error: " .. tostring(result))
        return nil
    end
    
    -- Create environment with custom require
    local env = {
        require = loadModule,
        game = game,
        workspace = workspace,
        script = script,
        print = print,
        warn = warn,
        error = error,
        pcall = pcall,
        xpcall = xpcall,
        getfenv = getfenv,
        setfenv = setfenv,
        loadstring = loadstring,
        math = math,
        table = table,
        string = string,
        type = type,
        pairs = pairs,
        ipairs = ipairs,
        next = next,
        select = select,
        unpack = unpack,
        tostring = tostring,
        tonumber = tonumber,
        os = {
            date = function(format)
                return os.date(format)
            end,
            time = os.time,
            clock = os.clock
        }
    }
    
    -- Execute module code
    local func, err = loadstring(result)
    if not func then
        warn("[Loader] Failed to compile module: " .. moduleName)
        warn("[Loader] Error: " .. tostring(err))
        return nil
    end
    
    -- Set environment
    setfenv(func, setmetatable(env, {__index = getfenv(0)}))
    
    -- Execute and cache
    local success, module = pcall(func)
    if success and module then
        MODULE_CACHE[moduleName] = module
        return module
    else
        warn("[Loader] Failed to execute module: " .. moduleName)
        warn("[Loader] Error: " .. tostring(module))
        return nil
    end
end

-- Set base URL
function loadModule.setBaseURL(url)
    BASE_URL = url
    if BASE_URL:sub(-1) ~= "/" then
        BASE_URL = BASE_URL .. "/"
    end
end

-- Get base URL
function loadModule.getBaseURL()
    return BASE_URL
end

-- Clear cache
function loadModule.clearCache()
    MODULE_CACHE = {}
end

-- Get cached modules
function loadModule.getCache()
    return MODULE_CACHE
end

return loadModule

