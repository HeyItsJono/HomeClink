-- Small clink script to automatically expand ~ to %HOME% in any command the user executes via Windows' CMD shell.

-- Look for escaped tildes, replaces any instance of "|~" with placeholder text.
local function tilde_escape(command)
	return string.gsub(command, "|~", "##EXPANDEDTILDEFORTILDEEXPANDER##")
end

-- Turn escaped tildes back into a regular tilde "~" after we've expanded unescaped tildes.
local function tilde_descape(command)
	return string.gsub(command, "##EXPANDEDTILDEFORTILDEEXPANDER##", "~")
end

-- Expand unescaped tildes with rl.expandetilde. Returns two values, the first is the expanded input command, the second is a boolean indicating whether any tildes were expanded. This second value not used in this script.
local function cmd_tilde_expander(input)
	local escaped_input = tilde_escape(input)
	local expanded_input, was_expanded = rl.expandtilde(escaped_input)
	local descaped_input = tilde_descape(expanded_input)
	return descaped_input
end

-- Register the main tilde expander function to run after the user has executed a command.
clink.onfilterinput(cmd_tilde_expander)