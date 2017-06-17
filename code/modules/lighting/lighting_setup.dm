/proc/create_all_lighting_objects()
	for(var/I in GLOB.sortedAreas)
		var/area/A = I

		if(!IS_DYNAMIC_LIGHTING(A))
			continue

		for(var/turf/T in A)

			if(!IS_DYNAMIC_LIGHTING(T))
				continue

			if(T.lighting_object)
				continue

			new/atom/movable/lighting_object(src)
			CHECK_TICK
		CHECK_TICK
