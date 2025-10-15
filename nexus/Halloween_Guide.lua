



function event_spawn(e)
    -- Start a timer named "shout" that fires every 900 seconds (15 minutes)
    eq.set_timer("shout", 600000)
end

function event_timer(e)
    if (e.timer == "shout") then
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

        local announceClass = eq.ChooseRandom(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)
        local key = "halloween_fastest_" .. string.lower(class_map[announceClass])
        local data = eq.get_data(key) or ""
        eq.debug(data)
        local time_str = "no time set"
        local name = "no one"
        if data ~= "" then
            local secs, player = data:match("(%d+)|(.*)")
            if secs then
                local min = math.floor(tonumber(secs) / 60)
                local sec = tonumber(secs) % 60
                time_str = string.format("%d minutes and %d seconds", min, sec)
                name = player
            end
        end
        
        if time_str == "no time set" then
            e.self:Shout("We are looking for the fastest dispatching " .. class_map[announceClass] .. "! Are you up for the challenge?")
        else
            e.self:Shout("The fastest dispatching " .. class_map[announceClass] .. " is " .. name .. " with " .. time_str .. "! Can you do better?")
        end
        
    end
end

function event_say(e)
    local player = e.other;
    local zone_short_name = "tipt";
    local zone_id = 289; -- Nexus zone ID
    local instance_version = 1; -- Use version 1 for custom spawns
    local instance_duration = 3600; -- 1 hour in seconds
    local teleport_x, teleport_y, teleport_z, teleport_h = -430, -2375, 18, 0; -- Safe coordinates in Nexus
    local player_name = e.other:GetCleanName()
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
    
    
    if (e.message:findi("hail")) then
        e.self:Say("Greetings, adventurer. We are looking for someone to help us with a special task.  We must cleanse an area of some very shady souls but only the best will be awarded.  Would you like to [apply]?  Or perhaps you want to know who the [fastest] is?  If you need your [corpse] back I can help with that also.")
    elseif (e.message:findi("apply")) then
        e.self:Say("Dispatch the shady souls as quickly as you can!")
        local instance_id = eq.create_instance(zone_short_name, instance_version, instance_duration);
        eq.assign_to_instance(instance_id);
        player:MovePCInstance(zone_id, instance_id, teleport_x, teleport_y, teleport_z, teleport_h);
    elseif (e.message:findi("corpse")) then
        e.self:Say("You should be more careful in the future.  Here, let me help you.");
        
         -- Summon all corpses for the player at their current location
        local x, y, z, h = e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading();
        local char_id = e.other:CharacterID();
        local corpse_count = e.other:GetCorpseCount();

        if corpse_count > 0 then
            eq.summon_all_player_corpses(char_id,x,y,z,h)
        end



    elseif (e.message:findi("fastest")) then
        local requested_class = nil
        for _, class_name in pairs(class_map) do
            if e.message:findi("fastest " .. class_name) then
                requested_class = class_name
                break
            end
        end
        if requested_class then
            local key = "halloween_fastest_" .. string.lower(requested_class)
            local data = eq.get_data(key) or ""
            if data == "" then
                e.self:Say("No one has set a fastest time for " .. requested_class .. " yet.")
            else
                local secs, player = data:match("(%d+)|(.*)")
                if secs then
                    local min = math.floor(tonumber(secs) / 60)
                    local sec = tonumber(secs) % 60
                    local time_str = string.format("%d minutes and %d seconds", min, sec)
                    e.self:Say("The fastest " .. requested_class .. " is " .. player .. " with a time of " .. time_str .. ".")
                else
                    e.self:Say("Error retrieving time for " .. requested_class .. ".")
                end
            end
        else
            e.self:Say("Please specify a class, e.g., 'fastest warrior'.")
        end
    end
end