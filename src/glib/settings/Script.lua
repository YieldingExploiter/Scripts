--[[

---- SettingsLib
About
| SettingsLib is a general Settings Library for every exploit-related use-case.

Project Link
| https://github.com/YieldingExploiter/Scripts/blob/main/src/glib/settings/Script.lua

Supported Environments
| Script-Ware
| Synapse-X
| Krnl

Required Functions
| readfile
| writefile
| isfile
| isfolder

License
| Copyright © 2021 YieldingCoder
|
| Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
|
| The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
|
| THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]] --
-- ANCHOR Pure Lua JSON Stringify/Parse Implementation
local JSON = {}
local function b( c )
  if type(c) ~= 'table' then return type(c) end
  local d = 1;
  for e in pairs(c) do
    if c[d] ~= nil then
      d = d + 1
    else
      return 'table'
    end
  end
  if d == 1 then
    return 'table'
  else
    return 'array'
  end
end
local function f( g )
  local h = { '\\'; '"'; '/'; '\b'; '\f'; '\n'; '\r'; '\t' }
  local i = { '\\'; '"'; '/'; 'b'; 'f'; 'n'; 'r'; 't' }
  for d, j in ipairs(h) do g = g:gsub(j, '\\' .. i[d]) end
  return g
end
local function k( l, m, n, o )
  m = m + #l:match('^%s*', m)
  if l:sub(m, m) ~= n then
    if o then error('Expected ' .. n .. ' near position ' .. m) end
    return m, false
  end
  return m + 1, true
end
local function p( l, m, q )
  q = q or ''
  local r = 'End of input found while parsing string.'
  if m > #l then error(r) end
  local j = l:sub(m, m)
  if j == '"' then return q, m + 1 end
  if j ~= '\\' then return p(l, m + 1, q .. j) end
  local s = { b = '\b'; f = '\f'; n = '\n'; r = '\r'; t = '\t' }
  local t = l:sub(m + 1, m + 1)
  if not t then error(r) end
  return p(l, m + 2, q .. (s[t] or t))
end
local function u( l, m )
  local v = l:match('^-?%d+%.?%d*[eE]?[+-]?%d*', m)
  local q = tonumber(v)
  if not q then error('Error parsing number at position ' .. m .. '.') end
  return q, m + #v
end
function JSON.stringify( c, w )
  local g = {}
  local x = b(c)
  if x == 'array' then
    if w then error('Can\'t encode array as key.') end
    g[#g + 1] = '['
    for d, q in ipairs(c) do
      if d > 1 then g[#g + 1] = ', ' end
      g[#g + 1] = JSON.stringify(q)
    end
    g[#g + 1] = ']'
  elseif x == 'table' then
    if w then error('Can\'t encode table as key.') end
    g[#g + 1] = '{'
    for y, z in pairs(c) do
      if #g > 1 then g[#g + 1] = ', ' end
      g[#g + 1] = JSON.stringify(y, true)
      g[#g + 1] = ':'
      g[#g + 1] = JSON.stringify(z)
    end
    g[#g + 1] = '}'
  elseif x == 'string' then
    return '"' .. f(c) .. '"'
  elseif x == 'number' then
    if w then return '"' .. tostring(c) .. '"' end
    return tostring(c)
  elseif x == 'boolean' then
    return tostring(c)
  elseif x == 'nil' then
    return 'null'
  else
    error('Unjsonifiable type: ' .. x .. '.')
  end
  return table.concat(g)
end
JSON.null = {}
function JSON.parse( l, m, A )
  m = m or 1;
  if m > #l then error('Reached unexpected end of input.') end
  local m = m + #l:match('^%s*', m)
  local B = l:sub(m, m)
  if B == '{' then
    local c, C, D = {}, true, true;
    m = m + 1;
    while true do
      C, m = JSON.parse(l, m, '}')
      if C == nil then return c, m end
      if not D then error('Comma missing between object items.') end
      m = k(l, m, ':', true)
      c[C], m = JSON.parse(l, m)
      m, D = k(l, m, ',')
    end
  elseif B == '[' then
    local E, q, D = {}, true, true;
    m = m + 1;
    while true do
      q, m = JSON.parse(l, m, ']')
      if q == nil then return E, m end
      if not D then error('Comma missing between array items.') end
      E[#E + 1] = q;
      m, D = k(l, m, ',')
    end
  elseif B == '"' then
    return p(l, m + 1)
  elseif B == '-' or B:match('%d') then
    return u(l, m)
  elseif B == A then
    return nil, m + 1
  else
    local F = { ['true'] = true; ['false'] = false; ['null'] = JSON.null }
    for G, H in pairs(F) do
      local I = m + #G - 1;
      if l:sub(m, I) == G then return H, I + 1 end
    end
    local J = 'position ' .. m .. ': ' .. l:sub(m, m + 10)
    error('Invalid json syntax starting at ' .. J)
  end
end

-- ANCHOR Constants
local confDir = 'cfg.settingsLib'

-- ANCHOR Ensure Function Stuff
local isFile = getfenv().isfile or function() return true end
local isFolder = getfenv().isfolder or function() end

if not writefile or not readfile or not makefolder then error('Invalid Environment') end

-- ANCHOR Main Class
local Settings = {}

Settings['JSONImplementation'] = setmetatable(
  {}, {
    __index = JSON;
    __newindex = function( t, k, v ) error('Cannot assign to table') end;
  }
)

Settings['Name'] = 'Unknown';
Settings['-v>>9_82'] = {};
-- Settings.Settings = setmetatable({},{
--   __newindex = function(t,k,v)

--     t:ForceSave()
--   end
-- })
function Settings:Set( k, v )
  self['-v>>9_82'][k] = v;
  self:ForceSave();
  return self;
end
function Settings:Get( k ) return self['-v>>9_82'][k]; end
function Settings:Default( k, d )
  if typeof(self:Get(k)) == 'nil' then self:Set(k, d) end
  return self;
end

function Settings:ForceSave()
  if not isFolder(confDir) then makefolder(confDir) end
  writefile(confDir .. '/' .. self.Name .. '.sl', JSON.stringify(self['-v>>9_82']))

  if not isfile or not isfile(confDir .. '/README.md') then
    writefile(
      confDir .. '/README.md', "# SettingsLib Config Folder\n"..
"\n"..
"## This Folder\n"..
"This folder contains the individual Files in [SLJSON](https://github.com/YieldingExploiter/Scripts/blob/main/src/glib/settings/docs/SLJSON.md) Format\n"..
"\n"..
"## About SettingsLib\n"..
"SettingsLib is a general Settings Library for every Roblox Exploit-related use-case.\n"..
"\n"..
"## Project Link\n"..
"[https://github.com/YieldingExploiter/Scripts/blob/main/src/glib/settings/Script.lua](https://github.com/YieldingExploiter/Scripts/blob/main/src/glib/settings/Script.lua)\n"..
"\n"..
"## LICENSE\n"..
"Copyright © 2021 YieldingCoder\n"..
"\n"..
"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n"..
"\n"..
"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n"..
"\n"..
"THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n"..
"")
  end
end
function Settings:Reload()
  local path = confDir .. '/' .. self.Name .. '.sl'
  if isFile(path) then
    self['-v>>9_82'] = JSON.parse(readfile(path))
  else
    self['-v>>9_82'] = { ['__sl.issljson'] = true };
  end
  return self;
end

Settings.Version = 1;

Settings.New = function( ScriptName )
  if not ScriptName then
    error('Provide the script name as the first parameter to Settings.new!')
  end
  local self = setmetatable({}, { __index = Settings })
  self.Name = ScriptName;
  self.New =
    function() error('Function Unavailable as a Proprety of SettingsInstance') end;
  self['-v>>9_82'] = {};
  self:Reload();
  self:ForceSave();
  if not self['-v>>9_82'].__sl.issljson then
    warn('Invalid SLJSON File - Missing __sl.issljson=true. Potential Corruption Occured.');
    self:Set('__sl.potentialCorruptionDetected', true)
  else
    self:Set('__sl.potentialCorruptionDetected', false)
  end
  self:Set('__sl.slversion', Settings.Version)
  return self
end;
Settings.new = Settings.New;
Settings.__proto__ = Settings;

return Settings;
