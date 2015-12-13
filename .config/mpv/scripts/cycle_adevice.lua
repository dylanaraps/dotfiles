--binds a hotkey to cycle through available audio devices
local numdevices = 0
local current = false
local currentd = ""
local devicenames = {};
local devicedesc = {};
local devices = {}
local function cycle_adevice()
	devices = mp.get_property_native("audio-device-list")
	for index, e in ipairs(devices) do
		if string.find(e.name, "alsa", 1, true) then
			numdevices = numdevices + 1
			devicenames[numdevices] = e.name;
			devicedesc[numdevices] = e.description;
		end
    end
	for i=1, numdevices do
		if current then
			mp.set_property("audio-device",devicenames[i])
			print("     (#)Audio="..devicedesc[i])
			mp.osd_message("Audio="..devicedesc[i])
			current = false
			break
		end
		currentd = devicenames[i]
		if string.find(mp.get_property("audio-device"), currentd, 1, true) or string.find(mp.get_property("audio-device"), "auto", 1, true) then
			current = true
			if i == numdevices then i = 1; end
		end
	end

end
mp.add_key_binding("A", "cycle_adevice", cycle_adevice)
