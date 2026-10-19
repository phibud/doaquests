-- Ring of lavastorm
function event_spell_effect(e)
  local client = nil;
  if (e.target and e.target.valid and e.target:IsClient()) then
    client = e.target:CastToClient();
  elseif (e.caster_id) then
    client = eq.get_entity_list():GetClientByID(e.caster_id);
  end
 
  if (client and client.valid) then
    local dest_x, dest_y, dest_z, dest_h;
    if (eq.is_dragons_of_norrath_enabled()) then
      dest_x, dest_y, dest_z, dest_h = 460, 460, -86, 454; -- Zone: Lavastorm v1
    else
      dest_x, dest_y, dest_z, dest_h = 1389, 1014, 131, 301; -- Zone: Lavastorm v0
    end

    if (eq.get_zone_id() == 27) then
      client:MovePCInstance(27, eq.get_zone_instance_id(), dest_x, dest_y, dest_z, dest_h);
      local pet = client:GetPet();
      if (pet.valid) then
        pet:GMMove(dest_x + 5, dest_y + 5, dest_z, dest_h);
      end
    else
      client:MovePC(27, dest_x, dest_y, dest_z, dest_h);
    end
  end

  return 1;
end
