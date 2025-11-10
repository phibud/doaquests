
local instance = {
	expedition = { name="Bastion of Thunder Instance", min_players=1, max_players=54 },
	instance   = { zone="bothunder", version=1, duration=eq.seconds("6h") },
	safereturn = { zone="potranquility", x=-1486, y=965, z=-880, h=81 },
	zonein     = { x=178, y=207, z=-1620, h=0 }
}

local flagRequired="pop_pos_askr_the_lost_final";

function event_say(e)
    local qglobals = eq.get_qglobals(e.self, e.other);
    local flag_value = qglobals[flagRequired];
    local dz = e.other:GetExpedition();
    local dzid = dz:GetID();

    if e.message:findi("hail") then
        if dzid==0 then 
            e.self:Say("Greetings traveler! I can help you create an [instance] of the Bastion of Thunder.");
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
                e.other:MovePCDynamicZone("bothunder");
            elseif flag_value=="1" then

                e.self:Say("Very well.  Take care!");
                e.other:MovePCDynamicZone("bothunder");
            else
                e.self:Say("You have not yet proven yourself worthy to enter the Bastion of Thunder. Return when you have done so.");
            end
        end
        
    end
end