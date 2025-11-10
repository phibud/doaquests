
local instance = {
	expedition = { name="Halls of Honor Instance", min_players=1, max_players=54 },
	instance   = { zone="hohonora", version=1, duration=eq.seconds("6h") },
	safereturn = { zone="potranquility", x=-1335, y=779, z=-873, h=0 },
	zonein     = { x=-2678.0, y=-323.0, z=3, h=0 }
}

local flagRequired="pop_pov_aerin_dar";

function event_spawn(e)
    
    
    
        
    
    
end

function event_say(e)
    local qglobals = eq.get_qglobals(e.self, e.other);
    local flag_value = qglobals[flagRequired];
    local dz = e.other:GetExpedition();
    local dzid = dz:GetID();

    if e.message:findi("hail") then
        if dzid==0 then 
            e.self:Say("Greetings traveler! I can help you create an [instance] of the Halls of Honor");
        else
            e.self:Say("Are you [ready] to enter?  ");
        end
    elseif e.message:findi("instance") then
        

        if dzid==0 then

            dz = e.other:CreateExpedition(instance);
            e.self:Say("Are you [ready] to enter?  ");
        else
            e.self:Say("You are already part of an expedition.");
        end

        
    elseif e.message:findi("ready") then
        local lvl = e.other:GetLevel();
        if dzid>0 then
            if lvl>=62 then
                e.self:Say("Very well.  Take care!");
                e.other:MovePCDynamicZone("hohonora");
            elseif flag_value=="1" then

                e.self:Say("Very well.  Take care!");
                e.other:MovePCDynamicZone("hohonora");
            else
                e.self:Say("You have not yet proven yourself worthy to enter the Halls of Honor. Return when you have done so.");
            end
        end
        
    elseif e.message:findi("test") then
        
        local lvl = e.other:GetLevel();
        e.self:Say("Your level is "..lvl);
        if lvl>=62 then
            e.self:Say("You meet the level requirement.");
        else
            e.self:Say("You do not meet the level requirement.");
        end
        
    end
end