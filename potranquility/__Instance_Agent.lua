
local instance = {
	expedition = { name="Bastion of Thunder Instance", min_players=1, max_players=54 },
	instance   = { zone="bothunder", version=1, duration=eq.seconds("6h") },
	safereturn = { zone="potranquility", x=-1486, y=965, z=-880, h=81 },
	zonein     = { x=-115, y=106, z=-1556.5, h=206 }
}


function event_say(e)
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
        if dzid>0 then
            e.self:Say("Very well.  Take care!");
            e.other:MovePCDynamicZone("bothunder");
        end
        
    end
end