/datum/subsystem/ticker/proc/setupFactions()
	// Populate the factions list:
	for(var/typepath in typesof(/datum/faction))
		var/datum/faction/F = new typepath()
		if(!F.name)
			qdel(F)
			continue
		else
			factions.Add(F)
			availablefactions.Add(F)
		CHECK_TICK

	// Populate the syndicate coalition:
	for(var/datum/faction/syndicate/S in factions)
		syndicate_coalition.Add(S)
		CHECK_TICK
