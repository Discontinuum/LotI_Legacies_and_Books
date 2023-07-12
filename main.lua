local lab_legacy_list = {"fire_dragon_legacy", "ice_dragon_legacy", "dark_dragon_legacy", "undead_legacy", "legacy_of_kings", "legacy_of_titans", "legacy_of_sorrow", "legacy_of_light", "legacy_of_phoenix", "legacy_of_exile", "legacy_of_the_freezing_north", "legacy_of_the_free"}

function wesnoth.wml_actions.loti_lab_add_missing_amlas(cfg)
	local unit = wesnoth.units.find_on_map(cfg)[1].__cfg
	local unit_variables = wml.get_child(unit, "variables")
	unit_variables.loti_lab_adding_amlas = true
	local cur_advs = {}
	local mods = wml.get_child(unit, "modifications")
	for m in wml.child_range(mods, "advancement") do
		if m["id"] ~= nil then
			cur_advs[m["id"]] = true
		end
	end
	for m in wml.child_range(unit, "advancement") do
		if m["id"] ~= nil then
			cur_advs[m["id"]] = true
		end
	end
	local found_legacy = nil
	for _, l in ipairs(lab_legacy_list) do
		if cur_advs[l] ~= nil then
			found_legacy = l
			break
		end
	end
	local found_awareness = cur_advs["awareness"] ~= nil
	if found_legacy ~= nil then
		if not found_awareness then
			table.insert(unit, wml.variables["loti_lab_awareness"][1])
		end
		for i,v in ipairs(wml.variables["loti_lab_"..found_legacy]) do
			table.insert(unit, v)
		end
		
	end
	
        --    local v = wml.get_child(unit, "variables")
        --    v.achieved_amla = true
        wesnoth.units.to_map(unit)

end
