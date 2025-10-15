
function event_say(e)
    local player = e.other;
    local zone_short_name = "tipt";
    local zone_id = 289; -- Nexus zone ID
    local instance_version = 1; -- Use version 1 for custom spawns
    local instance_duration = 3600; -- 1 hour in seconds
    local teleport_x, teleport_y, teleport_z, teleport_h = -430, -2375, 18, 0; -- Safe coordinates in Nexus
    local player_name = e.other:GetCleanName()
    
    
    
    if (e.message:findi("hail")) then
        e.self:Say("Had enough? I can send you [back] if you want.");

    elseif (e.message:findi("back")) then
        local inst_id = eq.get_zone_instance_id();

        eq.destroy_instance(inst_id);

        player:MovePCInstance(152, 0, -156, 121, -54, 0);
        player:MovePCInstance(zone_id, instance_id, teleport_x, teleport_y, teleport_z, teleport_h);
        
    end
end