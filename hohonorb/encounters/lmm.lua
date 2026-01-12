-- eq.unique_spawn(220015,0,0,2727,0,471,387); --Lord_Mithaniel_Marr untargetable
-- #Lord Mith Marr (220015) untargetable

local guardscount = 0;

function LMMSpawn(e)
	eq.debug("LMM Spawn function called...");
    
    guardscount = 0;
    eq.set_timer("spawn_delayed", 1000);
end

function LMMTimer(e)
    eq.debug("LMM Timer function called...");
	if e.timer == "spawn_delayed" then
		eq.unique_spawn(220014,0,0,2366,-151,444,387); --Edium,_Guardian_of_Marr
        eq.unique_spawn(220013,0,0,2366,154,444,387); --Halon_of_Marr
        eq.unique_spawn(220012,0,0,2495,0,444,387); --Ralthazor,_Champion_of_Marr
		eq.stop_timer(e.timer);
	end
end

function guardDeath(e)
    guardscount = guardscount + 1;
    eq.debug("Guard death detected. Current count: " .. guardscount);

    if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(220012) and not eq.get_entity_list():IsMobSpawnedByNpcTypeID(220013) and not eq.get_entity_list():IsMobSpawnedByNpcTypeID(220014) then
        eq.unique_spawn(220006,0,0,2727,0,471,387); --Lord_Mithaniel_Marr live version
        eq.depop_all(220015); --depop fake
    end
end

function LMMDeath(e)
    eq.debug("LMM Death function called...");

    eq.spawn2(202368,0,0,2380,-2,444,387); -- NPC: A_Planar_Projection
end

function event_encounter_load(e)
	eq.debug("LMM event loaded...");

    eq.register_npc_event("lmm", Event.spawn, 220015, LMMSpawn);
    eq.register_npc_event("lmm", Event.timer, 220015, LMMTimer);
    
    eq.register_npc_event("lmm", Event.death_complete, 220006, LMMDeath);

    eq.register_npc_event("lmm", Event.death_complete, 220012, guardDeath);
    eq.register_npc_event("lmm", Event.death_complete, 220013, guardDeath);
    eq.register_npc_event("lmm", Event.death_complete, 220014, guardDeath);
    
end

