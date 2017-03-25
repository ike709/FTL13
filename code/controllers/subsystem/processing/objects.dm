var/datum/subsystem/objects/SSobj
/datum/var/isprocessing = 0
/datum/proc/process()
	set waitfor = 0
	STOP_PROCESSING(SSobj, src)
	return 0

/datum/subsystem/objects
	name = "Objects"
	priority = 40
	flags = SS_NO_INIT

	var/list/atom_spawners = list()
	var/list/processing = list()
	var/list/currentrun = list()
	var/list/burning = list()
	var/datum/thing

/datum/subsystem/objects/New()
	NEW_SS_GLOBAL(SSobj)

/datum/subsystem/objects/stat_entry()
	..("P:[processing.len]")

/datum/subsystem/objects/fire(resumed = 0)
	if (!resumed)
		src.currentrun = processing.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		thing = currentrun[currentrun.len]
		currentrun.len--
		if(thing)
			thing.process(wait)
		else
			SSobj.processing -= thing
		if (MC_TICK_CHECK)
			return

	for(var/obj/burningobj in SSobj.burning)
		if(burningobj && (burningobj.burn_state == ON_FIRE))
			if(burningobj.burn_world_time < world.time)
				burningobj.burn()
		else
			SSobj.burning.Remove(burningobj)

/datum/subsystem/objects/Recover()
	processing = SSobj.processing
