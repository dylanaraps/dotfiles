-- use xrandr command to set output to best fitting fps rate
--  when playing videos with mpv.

utils = require 'mp.utils'

xrandr_blacklist = {}
function xrandr_parse_blacklist()
   -- use e.g. "--script-opts=xrandr-blacklist=25" to have xrand.lua not use 25Hz refresh rate

	-- Parse the optional "blacklist" from a string into an array for later use.
	-- For now, we only support a list of rates, since the "mode" is not subject
	--  to automatic change (mpv is better at scaling than most displays) and
	--  this also makes the blacklist option more easy to specify:
	local b = mp.get_opt("xrandr-blacklist")
	if (b == nil) then
		return
	end
	
	local i = 1
	for s in string.gmatch(b, "([^, ]+)") do
		xrandr_blacklist[i] = 0.0 + s
		i = i+1
	end
end
xrandr_parse_blacklist()


function xrandr_check_blacklist(mode, rate)
	-- check if (mode, rate) is black-listed - e.g. because the
	--  computer display output is known to be incompatible with the
	--  display at this specific mode/rate 
	
	for i=1,#xrandr_blacklist do
		r = xrandr_blacklist[i]
		
		if (r == rate) then
			mp.msg.log("v", "will not use mode '" .. mode .. "' with rate " .. rate .. " because option --script-opts=xrandr-blacklist said so")
			return true
		end
	end
	
	return false
end

xrandr_detect_done = false
xrandr_modes = {}
xrandr_connected_outputs = {}
function xrandr_detect_available_rates()
	if (xrandr_detect_done) then
		return
	end
	xrandr_detect_done = true
	
	-- invoke xrandr to find out which fps rates are available on which outputs
	
	local p = {}
	p["cancellable"] = false
	p["args"] = {}
	p["args"][1] = "xrandr"
	p["args"][2] = "-q"
	local res = utils.subprocess(p)
	
	if (res["error"] ~= nil) then
		mp.msg.log("info", "failed to execute 'xrand -q', error message: " .. res["error"])
		return
	end
	
	mp.msg.log("v","xrandr -q\n" .. res["stdout"])

	local output_idx = 1
	for output in string.gmatch(res["stdout"], '\n([^ ]+) connected') do
		
		table.insert(xrandr_connected_outputs, output)
		
		-- the first line with a "*" after the match contains the rates associated with the current mode
		local mls = string.match(res["stdout"], "\n" .. string.gsub(output, "%p", "%%%1") .. " connected.*")
		local r
		local mode
		local old_rate
		
		-- old_rate = 0 means "no old rate known to switch to after playback"
		old_rate = 0
		
		mode, r = string.match(mls, '\n   ([0-9x]+) ([^*\n]*%*[^\n]*)')
		
		if (r == nil) then
			-- if no refresh rate is reported active for an output by xrandr,
			-- search for the mode that is "recommended" (marked by "+" in xrandr's output)
			mode, r = string.match(mls, '\n   ([0-9x]+) ([^+\n]*%+[^\n]*)')
			if (r == nil) then 
				-- there is not even a "recommended" mode, so let's just use
				-- whatever first mode line there is
				mode, r = string.match(mls, '\n   ([0-9x]+) ([^+\n]*[^\n]*)')
			end
		else
			-- so "r" contains a hint to the current ("old") rate, let's remember
			--  it for later switching back to it.
			for s in string.gmatch(r, "([^ ]+)%*") do
				old_rate = s
			end
		end
		mp.msg.log("info", "output " .. output .. " mode=" .. mode .. " old rate=" .. old_rate .. " refresh rates = " .. r)
		
		xrandr_modes[output] = { mode = mode, rates_s = r, rates = {}, old_rate = old_rate }
		local i = 1
		for s in string.gmatch(r, "([^ +*]+)") do
			
			-- check if rate "r" is black-listed - this is checked here because 
			if (not xrandr_check_blacklist(mode, 0.0 + s)) then
				xrandr_modes[output].rates[i] = 0.0 + s
				i = i+1
			end
		end
		
		output_idx = output_idx + 1
	end
	
end

function xrandr_find_best_fitting_rate(fps, output)
	
	local xrandr_rates = xrandr_modes[output].rates
	
	-- try integer multipliers of 1 to 3, in that order
	for m=1,3 do
		
		-- check for a "perfect" match (where fps rates of e.g. 60.0 are not equal 59.9 or such)
		for i=1,#xrandr_rates do
			r = xrandr_rates[i]
			if (math.abs(r-(m * fps)) < 0.001) then
				return r
			end
		end
		
	end

	for m=1,3 do
		
		-- check for a "less precise" match (where fps rates of e.g. 60.0 and 59.9 are assumed "equal")
		for i=1,#xrandr_rates do
			r = xrandr_rates[i]
			if (math.abs(r-(m * fps)) < 0.2) then
				if (m == 1) then
					-- pass the original rate to xrandr later, because
					-- e.g. a 23.976 Hz mode might be displayed as "24.0",
					-- but still xrandr may set the better matching mode
					-- if the exact number is passed
					return fps
				else
					return r
				end
				
			end
		end
		
	end
	
	-- if no known frame rate is any "good", use the highest available frame rate,
	-- as this will probably cause the least "jitter"

	local mr = 0.0
	for i=1,#xrandr_rates do
		r = xrandr_rates[i]
		-- mp.msg.log("v","r=" .. r .. " mr=" .. mr)
		if (r > mr) then
			mr = r
		end
	end	
	
	return mr	
end


xrandr_active_outputs = {}
function xrandr_set_active_outputs()
	local dn = mp.get_property("display-names")
	
	if (dn ~= nil) then
		mp.msg.log("v","display-names=" .. dn)
		xrandr_active_outputs = {}
		for w in (dn .. ","):gmatch("([^,]*),") do 
			table.insert(xrandr_active_outputs, w)
		end
	end
end

-- last detected non-nil video frame rate:
xrandr_cfps = nil

-- for each output, we remember which refresh rate we set last, so
-- we do not unnecessarily set the same refresh rate again
xrandr_previously_set = {}

function xrandr_set_rate()

	local f = mp.get_property_native("fps")
	if (f == nil or f == xrandr_cfps) then
		-- either no change or no frame rate information, so don't set anything
		return
	end
	xrandr_cfps = f

	xrandr_detect_available_rates()
	
	xrandr_set_active_outputs()
	
	local vdpau_hack = false
	local old_vid = nil
	local old_position = nil
	if (mp.get_property("options/vo") == "vdpau" or mp.get_property("options/hwdec") == "vdpau") then
		-- enable wild hack: need to close and re-open video for vdpau,
		-- because vdpau barfs if xrandr is run while it is in use
		
		vdpau_hack = true
		old_position = mp.get_property("time-pos")
		old_vid = mp.get_property("vid")
		mp.set_property("vid", "no")
	end

   -- unless "--script-opts=xrandr-ignore_unknown_oldrate=true" is set, 
	--  xrandr.lua will not touch display outputs for which it cannot
	--  get information on the current refresh rate for - assuming that
	--  such outputs are "disabled" somehow.
	local ignore_unknown_oldrate = mp.get_opt("xrandr-ignore_unknown_oldrate")
	if (ignore_unknown_oldrate == nil) then
		ignore_unknown_oldrate = false
	end

	
	local outs = {}
	if (#xrandr_active_outputs == 0) then
		-- No active outputs - probably because vo (like with vdpau) does
		-- not provide the information which outputs are covered.
		-- As a fall-back, let's assume all connected outputs are relevant.
		mp.msg.log("v","no output is known to be used by mpv, assuming all connected outputs are used.")
		outs = xrandr_connected_outputs
	else
		outs = xrandr_active_outputs
	end
		
	-- iterate over all relevant outputs used by mpv's output:
	for n, output in ipairs(outs) do
		
		if (ignore_unknown_oldrate == false and xrandr_modes[output].old_rate == 0) then
			mp.msg.log("info", "not touching output " .. output .. " because xrandr did not indicate a used refresh rate for it - use --script-opts=xrandr-ignore_unknown_oldrate=true if that is not what you want.")
		else
			local bfr = xrandr_find_best_fitting_rate(xrandr_cfps, output)

			if (bfr == 0.0) then
				mp.msg.log("info", "no non-blacklisted rate available, not invoking xrandr")
			else
				mp.msg.log("info", "container fps is " .. xrandr_cfps .. "Hz, for output " .. output .. " mode " .. xrandr_modes[output].mode .. " the best fitting display fps rate is " .. bfr .. "Hz")

				if (bfr == xrandr_previously_set[output]) then
					mp.msg.log("v", "output " .. output .. " was already set to " .. bfr .. "Hz before - not changing")
				else 
					-- invoke xrandr to set the best fitting refresh rate for output 
					local p = {}
					p["cancellable"] = false
					p["args"] = {}
					p["args"][1] = "xrandr"
					p["args"][2] = "--output"
					p["args"][3] = output
					p["args"][4] = "--mode"
					p["args"][5] = xrandr_modes[output].mode
					p["args"][6] = "--rate"
					p["args"][7] = bfr

					local res = utils.subprocess(p)

					if (res["error"] ~= nil) then
						mp.msg.log("error", "failed to set refresh rate for output " .. output .. " using xrandr, error message: " .. res["error"])
					else
						xrandr_previously_set[output] = bfr
					end
				end
			end
		end
	end
	
	if (vdpau_hack) then
		mp.set_property("vid", old_vid)
		if (old_position ~= nil) then
    		mp.commandv("seek", old_position, "absolute", "keyframes")
		else
    		mp.msg.log("v", "old_position is 'nil' - not seeking after vdpau re-initialization")
		end
	end
end


function xrandr_set_old_rate()
	
	local outs = {}
	if (#xrandr_active_outputs == 0) then
		-- No active outputs - probably because vo (like with vdpau) does
		-- not provide the information which outputs are covered.
		-- As a fall-back, let's assume all connected outputs are relevant.
		mp.msg.log("v","no output is known to be used by mpv, assuming all connected outputs are used.")
		outs = xrandr_connected_outputs
	else
		outs = xrandr_active_outputs
	end
		
	-- iterate over all relevant outputs used by mpv's output:
	for n, output in ipairs(outs) do
		
		local old_rate = xrandr_modes[output].old_rate
		
		if (old_rate == 0) then
			mp.msg.log("v", "no previous frame rate known for output " .. output .. " - so no switching back.")
		else

			if (math.abs(old_rate-xrandr_previously_set[output]) < 0.001) then
				mp.msg.log("v", "output " .. output .. " is already set to " .. old_rate .. "Hz - no switching back required")
			else 

				mp.msg.log("info", "switching back output " .. output .. " that was previously set to " .. xrandr_previously_set[output] .. "Hz to mode " .. xrandr_modes[output].mode .. " with refresh rate " .. old_rate .. "Hz")

				-- invoke xrandr to set the best fitting refresh rate for output 
				local p = {}
				p["cancellable"] = false
				p["args"] = {}
				p["args"][1] = "xrandr"
				p["args"][2] = "--output"
				p["args"][3] = output
				p["args"][4] = "--mode"
				p["args"][5] = xrandr_modes[output].mode
				p["args"][6] = "--rate"
				p["args"][7] = old_rate

				local res = utils.subprocess(p)

				if (res["error"] ~= nil) then
					mp.msg.log("error", "failed to set refresh rate for output " .. output .. " using xrandr, error message: " .. res["error"])
				else
					xrandr_previously_set[output] = old_rate
				end
			end
		end
		
	end
	
end

-- we'll consider setting refresh rates whenever the video fps or the active outputs change:
mp.observe_property("fps", "native", xrandr_set_rate)
mp.observe_property("display-names", "native", xrandr_set_rate)

-- and we'll try to revert the refresh rate when mpv is shut down
mp.register_event("shutdown", xrandr_set_old_rate)

