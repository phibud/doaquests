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
    local flag_key = "PEQMigration"
    local flag_value = qglobals[flag_key]
    local player_name = e.other:GetCleanName() -- Get player's name

    

    if e.message:findi("hail") then
        if qglobals[flag_key] == nil then
            e.self:Say("Greetings " .. player_name .. "! I was pushed out of PEQ and have starting really liking this new area.  Perhaps I can help you [find] your way as well?")
        else
            if flag_value=="1" then
                e.self:Say(player_name .. ", your inventory is flagged for sync.  If your backup is available, it will take about 5-10 minutes to update.  Please log out now!  Please let me know if you want to [lock] further updates.")
            end

            if flag_value=="2" then
                e.self:Say(player_name .. ", your inventory is flagged for sync immediately.  If your backup is available, it will take about 5-10 minutes to update.  Please log out now!  Please let me know if you want to [lock] further updates.")
            end

            if flag_value=="3" then
                e.self:Say("Your inventory, spells, skills, AAs, discs should be updated.  If you would like to flag your account for another [sync] please let me know.  Do not do this if your inventory is good.")
            end
            
            if flag_value=="9" then
                e.self:Say("Your account is locked and will not receive any updates related to PEQ sync.  Please let me know if you wish to re-enable [sync].")
            end
            
        end
        
        
    elseif e.message:findi("find") then
        if flag_value == nil then
            
            local ini_file = "backups/peqbackups/Backup_" .. player_name .. ".ini" -- Construct INI file path (e.g., quests/Backup_Sentinok.ini)
            
            -- Read the INI file
            local file = io.open(ini_file, "r")
            if file then
                local status_level = nil
                for line in file:lines() do
                    
                    if line:match("^Level=") then
                        eq.debug("INI file: " .. line)
                        status_level = tonumber(line:match("%d+"))
                        eq.debug("Level: " .. status_level)
                        break
                    end
                end
                file:close()
                
                if status_level then
                    e.other:SetLevel(status_level)
                    e.self:Say("Your level has been set to " .. status_level .. ", " .. player_name .. "!")
                    e.self:Say("Please wait while we transfer your characters information.  This may take a bit.")
                    eq.set_global(flag_key, "1", 5, "F")
                else
                    e.self:Say("Sorry, " .. player_name .. ", no valid level found in your backup configuration.")
                    eq.debug("No Level key in: " .. ini_file)
                end
            else
                e.self:Say("Sorry, " .. player_name .. ", I could not read your backup configuration.")
                eq.debug("Failed to open INI file: " .. ini_file)
            end
        end
    elseif e.message:findi("sync") then
        e.self:Say("Your character is flagged for another sync.  Please wait while we transfer your characters information.  This may take a bit.")
        eq.set_global(flag_key, "1", 5, "F")

    elseif e.message:findi("lock") then
        e.self:Say("Your character is now locked from receiving additional updates.")
        eq.set_global(flag_key, "9", 5, "F")
    end
    
end