function event_spawn(e)
    -- peq_halloween
    if (eq.is_content_flag_enabled("peq_halloween")) then
        -- exclude mounts and pets
        e.self:ChangeRace(eq.ChooseRandom(14,60,82,85));
        e.self:ChangeSize(eq.ChooseRandom(6,7,8));
        e.self:ChangeTexture(1);
        e.self:ChangeGender(2);
        
    end
end

function event_death_complete(e)
    local class_map = {
        [1] = "Warrior",
        [2] = "Cleric",
        [3] = "Paladin",
        [4] = "Ranger",
        [5] = "Shadowknight",
        [6] = "Druid",
        [7] = "Monk",
        [8] = "Bard",
        [9] = "Rogue",
        [10] = "Shaman",
        [11] = "Necromancer",
        [12] = "Wizard",
        [13] = "Magician",
        [14] = "Enchanter",
        [15] = "Beastlord",
        [16] = "Berserker"
    }

    -- Retrieve quest globals for the NPC
    local qglobals = eq.get_qglobals(e.self);
    local inst_id = eq.get_zone_instance_id();
    local client_list = eq.get_entity_list():GetClientList();
    local player = nil;
    for client in client_list.entries do
        player = client; -- First client in single-player instance
        break;
    end
    eq.debug("A Shady Soul has been slain. Instance ID: " .. inst_id);
    
    -- Check if instance ID is valid and the challenge has started
    local start_key = "halloween_" .. inst_id .. "_start";
    if inst_id > 0 and qglobals[start_key] then
        -- Retrieve and increment kill count
        local kills_key = "halloween_" .. inst_id .. "_kills";
        local kills = tonumber(qglobals[kills_key]) or 0;
        kills = kills + 1;
        eq.set_global(kills_key, tostring(kills), 3, "H1");
        
        -- Retrieve total required kills
        local total_key = "halloween_" .. inst_id .. "_total";
        local total = tonumber(qglobals[total_key]) or 0;
        
        eq.debug("Killed " .. kills .. " of " .. total .. " shady souls!");
        player:Message(15, "Killed " .. kills .. " of " .. total .. " shady souls!");
        
        -- Check if the required number of kills has been reached
        if kills >= total then
            -- Calculate completion time
            local start_time = tonumber(qglobals[start_key]) or 0;
            local comp_time = os.time() - start_time;
            
            -- Get player from client list (single-player instance)
            
            
            if not player or not player:IsClient() then
                eq.debug("No valid player found in client list.");
                return;
            end
            
            local char_name = player:GetCleanName();
            local class_id = player:GetClass();
            local char_class = class_map[class_id] or "Unknown"; -- Fallback to "Unknown" if class ID is invalid
            eq.debug("Player found: " .. char_name .. ", Class: " .. char_class);
            
            -- Store fastest time in data bucket for the player's class
            local bucket_key = "halloween_fastest_" .. char_class:lower();
            local current_fastest = eq.get_data(bucket_key);
            local fastest_time, fastest_player = 999999, "";
            
            if current_fastest and current_fastest ~= "" then
                fastest_time, fastest_player = current_fastest:match("([^|]+)|([^|]+)");
                fastest_time = tonumber(fastest_time) or 999999;
            end
            
            if comp_time < fastest_time then
                char_name = char_name:gsub("|", "_"); -- Sanitize name to avoid breaking bucket parsing
                eq.set_data(bucket_key, comp_time .. "|" .. char_name);
                eq.debug("New fastest time for " .. char_class .. ": " .. comp_time .. " seconds by " .. char_name);
                player:Message(15, "New fastest time for " .. char_class .. "! Time: " .. comp_time .. " seconds.");
            else
                eq.debug("Current fastest time for " .. char_class .. ": " .. fastest_time .. " seconds by " .. fastest_player);
                player:Message(15, "Challenge complete! Time: " .. comp_time .. " seconds. Fastest for " .. char_class .. ": " .. fastest_time .. " seconds by " .. fastest_player .. ".");
            end
            
            -- Clean up instance
            player:Message(15, "I've seen enough.  Well done!  I'll send for you if you are the top applicant.  Should hear from me in a couple of weeks.......");
            eq.destroy_instance(inst_id);

            player:MovePCInstance(152, 0, -156, 121, -54, 0);
        end
    else
        player:Message(15, "You feel as though you are being watched.  Lets make sure they remember!");
        eq.debug("Starting instance challenge...");
        eq.set_global("halloween_" .. inst_id .. "_start", tostring(os.time()), 3, "H1");
        eq.set_global("halloween_" .. inst_id .. "_kills", "0", 3, "H1");
        eq.set_global("halloween_" .. inst_id .. "_total", "15", 3, "H1");

        -- Retrieve and increment kill count
        local kills_key = "halloween_" .. inst_id .. "_kills";
        local kills = tonumber(qglobals[kills_key]) or 0;
        kills = kills + 1;
        eq.set_global(kills_key, tostring(kills), 3, "H1");
    end
end

function event_death(e)
    -- Class ID to name mapping
    
end