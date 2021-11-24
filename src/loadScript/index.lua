-- Loads a script from a URL
-- Copyright (c) 2021 YieldingCoder. All Rights Reserved.
local DEPWARN = (function()
	local v = false;
	local function pad(str,int,chr)
		repeat str=chr..str until #str >= int;
		return str;
	end;
	local function d(i)
		i=pad(tostring(i),3,'0');
		warn('[D'..i..'] This method is deprecated! See https://yieldingexploiter.github.io/RBX-Deprecated/D'..i..' for more information.');
		if v == false then
			print('A list of deprecated functions found here (and what to use instead), can be found here: https://github.com/YieldingExploiter/RBX-Deprecated');
			v=true;
		end;
	end;
	local function w(i)
		i=pad(tostring(i),3,'0');
		warn('[D'..i..'] This method is deprecated! See https://yieldingexploiter.github.io/RBX-Deprecated/W'..i..' for more information.');
		if v == false then
			print('A list of deprecated functions found here (and what to use instead), can be found here: https://github.com/YieldingExploiter/RBX-Deprecated');
			v=true;
		end;
	end;
	return {d;w;}
end)();
local d = DEPWARN[1];
local w = DEPWARN[2];
local dep = d;
local wrn = w;

local MD5;
local runScriptUrl = function(url,location,children)
	local scriptFuncs = {}
	function scriptFuncs:GetHash()MD5=MD5 or loadstring(game:HttpGetAsync('https://yieldingexploiter.github.io/Scripts/src/uploaded/md5.lua?'))();w(1);return MD5.Calc(self.Source);end;
	function scriptFuncs:ClearAllChildren()	children={};end;
	function scriptFuncs:Clone()return error('Not Implemented');end;
	function scriptFuncs:clone()d(5);return error('Not Implemented');end;
	function scriptFuncs:Destroy()return warn('Not Implemented (Cannot stop threads in fake script)');end;
	function scriptFuncs:destroy()d(2)return warn('Not Implemented (Cannot stop threads in fake script)');end;
	function scriptFuncs:remove()d(3)return warn('Not Implemented (Cannot stop threads in fake script)');end;
	function scriptFuncs:Remove()d(4)return warn('Not Implemented (Cannot stop threads in fake script)');end;
	function scriptFuncs:FindFirstAncestor(n)if location.Name==n then return location;else return location:FindFirstAncestor(n);end;end;
	function scriptFuncs:FindFirstAncestorOfClass(n)if location.ClassName==n then return location;else return location:FindFirstAncestorOfClass(n);end;end;
	function scriptFuncs:FindFirstAncestorWhichIsA(n)if location:IsA(n) then return location;else return location:FindFirstAncestorWhichIsA(n);end;end;
	local FindChild = function(cb,recursive)
		for _,o in pairs(children) do
			if (cb(o))then return o;end;
			if recursive then
				for _,o in pairs(o:GetDescendants()) do
					if (cb(o))then return o;end;
				end;
			end;
		end;
	end;
	function scriptFuncs:FindFirstChild(n,rec) return FindChild(function(c)return c.Name==n;end,rec);end;
	function scriptFuncs:FindFirstChildOfClass(n,rec) return FindChild(function(c)return c.ClassName==n;end,rec);end;
	function scriptFuncs:FindFirstChildWhichIsA(n,rec) return FindChild(function(c)return c:IsA(n);end,rec);end;
	function scriptFuncs:FindFirstDescendant(n) return self:FindFirstChild(n,true);end;
	function scriptFuncs:GetActor(n) return error('Unimplemented (unknown functionality)')end;
	local attr = {};
	function scriptFuncs:GetAttribute(v) return self[v] or attr[v];end;
	function scriptFuncs:GetAttributeChangedSignal(v) return error('Unimplemented (to be added)')end;
	function scriptFuncs:GetAttributes() return attr;end;
	function scriptFuncs:GetChildren() return children;end;
	function scriptFuncs:GetDebugId()return warn('Cannot get Debug ID for virtual script') or ''end;
	function scriptFuncs:GetDescendants()
		local desc = {};
		for _,o in pairs(children) do
			table.insert(desc,o);
			for _,o in pairs(o:GetDescendants()) do
				table.insert(desc,o);
			end;
		end;
		return desc;
	end;
	function scriptFuncs:GetFullName()return self.Parent:GetFullName()..'.'..self.Name;end;
	function scriptFuncs:GetPropretyChangedSignal()return error('Not Implemented (too lazy)')end;
	function scriptFuncs:IsA(v)return v == "Instance" or v == "Script" or v == "LocalScript" and true or warn('IsA() might not work as expected!') or false;end;
	function scriptFuncs:IsAncestorOf()error('Unimplemented')end;
	scriptFuncs.Remove=scriptFuncs.Destroy;
	function scriptFuncs:SetAttribute(a,v)attr[a]=v;end;
	function scriptFuncs:WaitForChild(v)return children[v] or error('Unimplemented')end;
	function scriptFuncs:getChildren()d(6);return self:GetChildren();end;
	function scriptFuncs:children()d(1);return self:GetChildren();end;
	
	local script = setmetatable({
		-- BaseScript
		["Disabled"]=false;
		["LinkedSource"]=nil;
		-- LuaSourceContainer
		["CurrentEdior"]=nil;
		-- Instance
		["Archivble"]=true;
		["ClassName"]="LocalScript";
		["DataCost"]=0;
		["Name"]="LocalScript (Virtual)";
		["Parent"]=location;
		["RobloxLocked"]=false;
		-- deprecated
		["archivable"]=false;
		["className"]='LocalScript';
		-- exists
		["Exists"]=false;
		["Children"]=children;
		["Source"]=game:HttpGetAsync(url);
	},{
		__index=function(t,k)
			return t.Children[k] or scriptFuncs[k];
		end	
	})
	local Source = 'return (function(script)\n'..script.Source..'\nend)';
	local f = loadstring(Source)()
	return f(script)
end
