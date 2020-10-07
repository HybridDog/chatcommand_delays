-- only tell the time if the chatcommand took noticeable time
local time_threshold = 0.01

local message_form = "%s " .. minetest.colorize("#f3d2ff", "(%.3g s)")

-- Override the chatcommand function of builtin to tell the time the command
-- took; this must always be kept up to date
minetest.registered_on_chat_messages[1] = function(name, message)
	if message:sub(1,1) ~= "/" then
		return
	end

	local cmd, param = string.match(message, "^/([^ ]+) *(.*)")
	if not cmd then
		core.chat_send_player(name, "-!- Empty command")
		return true
	end

	param = param or ""

	-- Run core.registered_on_chatcommands callbacks.
	if core.run_callbacks(core.registered_on_chatcommands, 5, name, cmd, param) then
		return true
	end

	local cmd_def = core.registered_chatcommands[cmd]
	if not cmd_def then
		core.chat_send_player(name, "-!- Invalid command: " .. cmd)
		return true
	end
	local has_privs, missing_privs = core.check_player_privs(name, cmd_def.privs)
	if has_privs then
		core.set_last_run_mod(cmd_def.mod_origin)

		-- ## changed here
		local t1 = minetest.get_us_time()
		-- ##

		local success, result = cmd_def.func(name, param)

		-- ## and here
		local delay = (minetest.get_us_time() - t1) / 1000000
		if delay > time_threshold then
			result = message_form:format((result or ""), delay)
		end
		-- ##

		if success == false and result == nil then
			core.chat_send_player(name, "-!- Invalid command usage")
			local help_def = core.registered_chatcommands["help"]
			if help_def then
				local _, helpmsg = help_def.func(name, cmd)
				if helpmsg then
					core.chat_send_player(name, helpmsg)
				end
			end
		elseif result then
			core.chat_send_player(name, result)
		end
	else
		core.chat_send_player(name, "You don't have permission"
				.. " to run this command (missing privileges: "
				.. table.concat(missing_privs, ", ") .. ")")
	end
	return true  -- Handled chat message
end
