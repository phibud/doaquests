function event_spawn(e)
    -- peq_halloween
    if (eq.is_content_flag_enabled("peq_halloween")) then
        -- exclude mounts and pets
        e.self:ChangeRace(eq.ChooseRandom(14,60,82,85));
        e.self:ChangeTexture(1);
        e.self:ChangeGender(2);
    end
end

function event_say(e)
    local qglobals = eq.get_qglobals(e.self, e.other)
    local flag_key = "PEQMigrationDON"
    local flag_value = qglobals[flag_key]
    local player_name = e.other:GetCleanName() -- Get player's name
    local familiar = false

    local ini_file = "backups/peqbackups/Backup_" .. player_name .. ".ini" -- Construct INI file path (e.g., quests/Backup_Sentinok.ini)
    
    -- Read the INI file
    local file = io.open(ini_file, "r")
    if file then
        file:close()
        familiar = true
    end
            
    if qglobals[flag_key] == nil then
        if e.message:findi("hail") then
            
            if familiar then
                e.self:Say("Greetings " .. player_name .. "! I remember you from PEQ!  I can facilitate a introduction to Norrath's [Keepers] or the Dark [Reign] if you would like me to.")
            else
                e.self:Say("Greetings " .. player_name .. "! I don't think I'm familiar with you.")  
            end
        elseif e.message:findi("keepers") then
            if familiar then
                e.self:Say("Consider it done, " .. player_name .. ".  Safe travels!")
                eq.set_global(flag_key, "10", 5, "F")
            end
        elseif e.message:findi("reign") then
            if familiar then
                e.self:Say("Consider it done, " .. player_name .. ".  Safe travels!")
                eq.set_global(flag_key, "20", 5, "F")
            end
        end
    else
        if e.message:findi("hail") then
            if qglobals[flag_key] == "10" then
                e.self:Say("I havent had a chance to facilitate your introduction with Norrath's Keepers.  Please check back again later " .. player_name .. "! ")
            elseif qglobals[flag_key] == "20" then
                e.self:Say("I havent had a chance to facilitate your introduction with the Dark Reign.  Please check back again later " .. player_name .. "! ")
            elseif qglobals[flag_key] == "11" then
                e.self:Say("The Norrath's Keepers should be more than familir with your name now.  Go see for yourself " .. player_name .. "! ")
            elseif qglobals[flag_key] == "21" then
                e.self:Say("The Dark Reign should be more than familir with your name now.  Go see for yourself " .. player_name .. "! ")
            end
        end

    end
    
    
end