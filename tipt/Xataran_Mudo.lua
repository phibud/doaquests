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
    local inst_id = eq.get_zone_instance_id();
    eq.debug("Xataran Mudo has been slain. Instance ID: " .. inst_id);
    e.self:Shout("I will be back.....  But my minions will still get you eventually!")
end

function event_death(e)
    -- Class ID to name mapping
    
end