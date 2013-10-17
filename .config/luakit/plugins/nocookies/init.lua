--------------------------------------------------------
-- NoCookies plugin for luakit                        --
--------------------------------------------------------

-- Get Lua environment
local os = require "os"
local tonumber = tonumber
local assert = assert
local table = table
local string = string

-- Get luakit environment
local webview = webview
local add_binds = add_binds
local lousy = require "lousy"
local sql_escape = lousy.util.sql_escape
local capi = { luakit = luakit, sqlite3 = sqlite3 }

module("plugins.nocookies")

-- Default blocking value
enable_cookies = false

create_table = [[
CREATE TABLE IF NOT EXISTS by_domain (
    id INTEGER PRIMARY KEY,
    domain TEXT,
    enable_cookies INTEGER
);]]

db = capi.sqlite3{ filename = capi.luakit.data_dir .. "/nocookies.db" }
db:exec("PRAGMA synchronous = OFF; PRAGMA secure_delete = 1;")
db:exec(create_table)

local function btoi(bool) return bool and 1 or 0    end
local function itob(int)  return tonumber(int) ~= 0 end

local function get_domain(uri)
    uri = assert(lousy.uri.parse(uri), "invalid uri")
    return string.lower(uri.host)
end

local function match_domain(domain)
    local rows = db:exec(string.format("SELECT * FROM by_domain "
        .. "WHERE domain == %s;", sql_escape(domain)))
    if rows[1] then return rows[1] end
end

local function update(id, field, value)
    db:exec(string.format("UPDATE by_domain SET %s = %d WHERE id == %d;",
        field, btoi(value), id))
end

local function insert(domain, enable_cookies)
    db:exec(string.format("INSERT INTO by_domain VALUES (NULL, %s, %d);",
        sql_escape(domain), btoi(enable_cookies)))
end

function webview.methods.toggle_cookies(view, w)
    local domain = get_domain(view.uri)
    local enable_cookies = _M.enable_cookies
    local row = match_domain(domain)

    if row then
        enable_cookies = itob(row.enable_cookies)
        update(row.id, "enable_cookies", not enable_cookies)
    else
        insert(domain, not enable_cookies, _M.enable_plugins)
    end

    w:notify(string.format("%sabled cookies for domain: %s",
        enable_cookies and "Dis" or "En", domain))
end

webview.init_funcs.nocookies_load = function (view, w)
    view:add_signal("load-status", function (v, status)
        if status ~= "committed" or v.uri == "about:blank" then return end
        local enable_cookies = _M.enable_cookies
        local domain = get_domain(v.uri)
        local row = match_domain(domain)
        if row then
            enable_cookies = itob(row.enable_cookies)
        end
        view.enable_cookies = enable_cookies
    end)
end

local buf = lousy.bind.buf
add_binds("normal", {
    buf("^,tc$", function (w) w:toggle_cookies() end)
})
