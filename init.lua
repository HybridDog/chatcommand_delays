local load_time_start = minetest.get_us_time()


-- only tell the time if the chatcommand took noticeable time
local treshold = 0.01

-- Override the chatcommand function of builtin to tell the time the command took
minetest.registered_on_chat_messages[1] = function(name, message)
	local cmd, param = string.match(message, "^/([^ ]+) *(.*)")
	if not param then
		param = ""
	end
	local cmd_def = core.chatcommands[cmd]
	if not cmd_def then
		return false
	end
	local has_privs, missing_privs = core.check_player_privs(name, cmd_def.privs)
	if has_privs then
		core.set_last_run_mod(cmd_def.mod_origin)

		-- ## changed here
		local t1 = minetest.get_us_time()
		-- ##

		local success, message = cmd_def.func(name, param)

		-- ## and here
		local delay = (minetest.get_us_time()-t1)/1000000
		if delay > treshold then
			--message = (message or "") .. " (" .. delay .. " s)"
			message = (message or "") .. minetest.colorize("#f3d2ff", " (" .. delay .. " s)")
			--" Chatcommand executed after " .. delay .. " seconds."
		end
		-- ##

		if message then
			core.chat_send_player(name, message)
		end
	else
		core.chat_send_player(name, "You don't have permission"
				.. " to run this command (missing privileges: "
				.. table.concat(missing_privs, ", ") .. ")")
	end
	return true  -- Handled chat message
end


local time = (minetest.get_us_time() - load_time_start) / 1000000
local msg = "[chatcommand_delays] loaded after ca. " .. time .. " seconds."
if time > 0.01 then
	print(msg)
else
	minetest.log("info", msg)
end
