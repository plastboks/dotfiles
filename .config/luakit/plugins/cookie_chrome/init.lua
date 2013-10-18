-- Grab what we need from the Lua environment
local table = table
local string = string
local io = io
local print = print
local pairs = pairs
local ipairs = ipairs
local math = math
local assert = assert
local setmetatable = setmetatable
local rawget = rawget
local rawset = rawset
local type = type
local os = os
local error = error

-- Grab the luakit environment we need
local cookies = require("cookies")
local lousy = require("lousy")
local chrome = require("chrome")
local markdown = require("markdown")
local sql_escape = lousy.util.sql_escape
local add_binds = add_binds
local add_cmds = add_cmds
local webview = webview
local capi = {
    luakit = luakit
}

module("plugins.show_cookies.chrome")

-- Display the cookie uri and title.
show_uri = false

stylesheet = [===[
.cookie {
    line-height: 1.6em;
    padding: 0.4em 0.5em;
    margin: 0;
    left: 0;
    right: 0;
    border: 1px solid #fff;
    border-radius: 0.3em;
}

.cookie:nth-child(2n+1) {
    background: #FAFAFA;
}

.cookie .host,{
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.cookie .top {
    position: relative;
}

.cookie .host {
    font-weight: normal;
    font-size: 1.3em;
    text-decoration: none;
}

.cookie .data .name {
    padding-right: 20px;
}

.cookie .uri, .cookie .desc {
    display: none;
}

.cookie .uri {
    color: #aaa;
}

.cookie .bottom {
    white-space: nowrap;
}

.cookie .bottom a {
    text-decoration: none;
    -webkit-user-select: none;
    cursor: default;
}

.cookie .bottom a:hover {
    cursor: pointer;
}

.cookie .desc {
    color: #222;
    border-left: 0.3em solid #ddd;
    margin: 0 0 0.2em 0.5em;
    padding: 0 0 0 0.5em;
    max-width: 60em;
}

.cookie .desc > * {
    margin-top: 0.2em;
    margin-bottom: 0.2em;
}

.cookie .desc > :first-child {
    margin-top: 0;
}

.cookie .desc > :last-child {
    margin-bottom: 0;
}

.cookie .controls a {
    color: #888;
    padding: 0.1em 0.4em;
    margin: 0 0;
}

.cookie .controls a:hover {
    background-color: #fff;
    -webkit-border-radius: 0.2em;
    -webkit-box-shadow: 0 0.1em 0.1em #666;
}

.cookie .date {
    color: #444;
    margin-right: 0.2em;
}

#templates {
    display: none;
}

#blackout {
    position: fixed;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    opacity: 0.5;
    background-color: #000;
    z-index: 100;
}

#edit-dialog {
    position: fixed;
    z-index: 101;
    font-size: 1.3em;
    font-weight: 100;

    top: 6em;
    left: 50%;
    margin-left: -20em;
    margin-bottom: 6em;
    padding: 2em;
    width: 36em;

    background-color: #eee;
    border-radius: 0.5em;
    box-shadow: 0 0.5em 1em #000;
}

#edit-dialog td:first-child {
    vertical-align: middle;
    text-align: right;
    width: 4em;
}

#edit-dialog td {
    padding: 0.3em;
}

#edit-dialog input, #edit-dialog textarea {
    font-size: inherit;
    border: none;
    outline: none;
    margin: 0;
    padding: 0;
    background-color: #fff;
    border-radius: 0.25em;
    box-shadow: 0 0.1em 0.1em #888;
}

#edit-dialog input[type="text"], #edit-dialog textarea {
    width: 30em;
    padding: 0.5em;
}

#edit-dialog input[type="button"] {
    padding: 0.5em 1em;
    margin-right: 0.5em;
    color: #444;
}

#edit-dialog textarea {
    height: 5em;
}

#edit-view {
    display: none;
}
]===]


local html = [==[
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Cookies</title>
    <style type="text/css">
        {%stylesheet}
    </style>
</head>
<body>
    <header id="page-header">
        <span id="search-box">
            <input type="text" id="search" placeholder="Search cookies..." />
            <input type="button" id="clear-button" value="X" />
        </span>
        <input type="button" id="search-button" class="button" value="Search" />
    </header>

    <div id="results" class="content-margin"></div>

    <div id="edit-view" stlye="position: absolute;">
        <div id="blackout"></div>
        <div id="edit-dialog">
            <table>
                <tr><td>Host:</td> <td><input class="host" type="text" /></td> </tr>
                <tr><td>URI:</td>   <td><input class="uri"   type="text" /></td> </tr>
                <tr><td>Tags:</td>  <td><input class="tags"  type="text" /></td> </tr>
                <tr><td>Info:</td>  <td><textarea class="desc"></textarea></td>  </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="button" class="submit-button" value="Save" />
                        <input type="button" class="cancel-button" value="Cancel" />
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div id="templates" class="hidden">
        <div id="cookie-skelly">
            <div class="cookie">
                <div class="host"></div>
                <div class="data">
                  <span class="name"></span>
                  <span class="value"></span>
                </div>
                <div class="desc"></div>
                <div class="bottom">
                    <span class="date"></span>
                    <span class="controls">
                        <a class="edit-button">edit</a>
                        <a class="delete-button">delete</a>
                    </span>
                </div>
            </div>
        </div>
    </div>
</body>
]==]

local main_js = [=[
$(document).ready(function () { 'use strict'

    var cookie_html = $("#cookie-skelly").html(),
        $results = $("#results"), $search = $("#search"),
        $edit_view = $("#edit-view"), $edit_dialog = $("#edit-dialog");

    function make_cookie(b) {
        var $b = $(cookie_html);

        $b.attr("cookie_id", b.id);
        $b.find(".name").text(b.name);
        $b.find(".host").text(b.host);
        $b.find(".value").text(b.value);
        $b.find(".date").text(b.date);

        return $b.prop("outerHTML");
    }

    function show_edit(b) {
        b = b || {};
        var $e = $edit_dialog;
        $e.attr("cookie_id", b.id);
        $e.attr("created", b.created);
        $e.find(".host").val(b.host);
        $e.find(".uri").val(b.uri);
        $e.find(".tags").val(b.tags);
        $e.find(".desc").val(b.desc);
        $edit_view.fadeIn("fast", function () {
            $edit_dialog.find(".host").focus();
        });
    }

    function find_cookie_parent(that) {
        return $(that).parents(".cookie").eq(0);
    }

    function search() {

        var results = cookies_search({ query: $search.val() });

        if (results.length === "undefined") {
            $results.empty();
            return;
        }

        /* display results */
        var html = "";
        for (var i = 0; i < results.length; i++)
            html += make_cookie(results[i]);

        $results.get(0).innerHTML = html;
    };

    /* input field callback */
    $search.keydown(function(ev) {
        if (ev.which == 13) { /* Return */
            search();
            $search.blur();
            reset_mode();
        }
    });

    // 'delete' callback
    $results.on("click", ".cookie .controls .delete-button", function (e) {
        var $b = find_cookie_parent(this);
        // delete cookie from database
        cookies_remove(parseInt($b.attr("cookie_id")));
        // remove/hide cookie from list
        $b.slideUp(function() { $b.remove(); });
    });

    $results.on("click", ".cookie .tags a", function () {
        $search.val($(this).text());
        search();
    });

    $results.on("click", ".cookie .controls .edit-button", function (e) {
        var $b = find_cookie_parent(this);
        var b = cookies_get(parseInt($b.attr("cookie_id")));
        show_edit(b);
    });

    function edit_submit() {
        var $e = $edit_dialog, id = $e.attr("cookie_id"),
            created = $e.attr("created");

        try {
            cookies_add($e.find(".uri").val(), {
                host: $e.find(".host").val(),
                tags: $e.find(".tags").val(),
                desc: $e.find(".desc").val(),
                created: created ? parseInt(created) : undefined,
            });
        } catch (err) {
            alert(err);
            return;
        }

        // Delete existing cookie (only when editing cookie)
        if (id)
            cookies_remove(parseInt(id));

        search();

        $edit_view.fadeOut("fast");
    };

    $edit_dialog.on("click", ".submit-button", function (e) {
        edit_submit();
    });

    $edit_dialog.find('input[type="text"]').keydown(function(ev) {
        if (ev.which == 13) /* Return */
            edit_submit();
    });

    $edit_dialog.on("click", ".cancel-button", function (e) {
        $edit_view.fadeOut("fast");
    });

    $("#new-button").click(function () {
        show_edit();
    });

    $("#clear-button").click(function () {
        $search.val("");
        search();
    });

    $("#search-button").click(function () {
        search();
    });

    search();

    var values = new_cookie_values();
    if (values)
        show_edit(values);
});
]=]

local new_cookie_values

export_funcs = {
    cookies_search = function (opts)
        if not cookies.db then cookies.init() end
        local sql = { "SELECT", "*", "FROM moz_cookies" }

        local where, args, argc = {}, {}, 1

        string.gsub(opts.query or "", "(-?)([^%s]+)", function (notlike, term)
            if term ~= "" then
                table.insert(where, (notlike == "-" and "NOT " or "") ..
                    string.format("(text GLOB ?%d)", argc, argc))
                argc = argc + 1
                table.insert(args, "*"..string.lower(term).."*")
            end
        end)

        if #where ~= 0 then
            --sql[2] = [[ *, lower(uri||title||desc||tags) AS text ]]
            --table.insert(sql, "WHERE " .. table.concat(where, " AND "))
        end

        local order_by = [[ ORDER BY expiry DESC LIMIT ?%d OFFSET ?%d ]]
        table.insert(sql, string.format(order_by, argc, argc+1))

        local limit, page = opts.limit or 100, opts.page or 1
        table.insert(args, limit)
        table.insert(args, limit > 0 and (limit * (page - 1)) or 0)

        sql = table.concat(sql, " ")

        if #where ~= 0 then
            local wrap = [[SELECT *
                FROM (%s)]]
            sql = string.format(wrap, sql)
        end

        local rows = cookies.db:exec(sql, args)

        local date = os.date
        for _, row in ipairs(rows) do
            row.date = date("%Y-%m-%d", row.expiry)
            local desc = row.desc
            if desc and string.find(desc, "%S") then
                row.markdown_desc = markdown(desc)
            end
        end

        return rows
    end,

    cookies_get = cookies.get,
    cookies_remove = cookies.remove,

}

chrome.add("cookies", function (view, meta)
    local uri = "luakit://cookies/"

    local style = chrome.stylesheet .. _M.stylesheet

    if not _M.show_uri then
        style = style .. " .cookie .uri { display: none !important; } "
    end

    local html = string.gsub(html, "{%%(%w+)}", { stylesheet = style })

    view:load_string(html, uri)

    function on_first_visual(_, status)
        -- Wait for new page to be created
        if status ~= "first-visual" then return end

        -- Hack to run-once
        view:remove_signal("load-status", on_first_visual)

        -- Double check that we are where we should be
        if view.uri ~= uri then return end

        -- Export luakit JS<->Lua API functions
        for name, func in pairs(export_funcs) do
            view:register_function(name, func)
        end

        view:register_function("reset_mode", function ()
            meta.w:set_mode() -- HACK to unfocus search box
        end)

        -- Load jQuery JavaScript library
        local jquery = lousy.load("lib/jquery.min.js")
        local _, err = view:eval_js(jquery, { no_return = true })
        assert(not err, err)

        -- Load main luakit://download/ JavaScript
        local _, err = view:eval_js(main_js, { no_return = true })
        assert(not err, err)
    end

    view:add_signal("load-status", on_first_visual)
end)

chrome_page = "luakit://cookies/"

local key, buf = lousy.bind.key, lousy.bind.buf
add_binds("normal", {
    buf("^gc$", "Open cookies manager in the current tab.",
        function(w)
            w:navigate(chrome_page)
        end),

    buf("^gC$", "Open cookies manager in a new tab.",
        function(w)
            w:new_tab(chrome_page)
        end)
})

local cmd = lousy.bind.cmd
add_cmds({
    cmd("cookies", "Open cookies manager in a new tab.",
        function (w)
            w:new_tab(chrome_page)
        end)
})
