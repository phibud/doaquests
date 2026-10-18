-- Ring of lavastorm
function event_spell_effect(e)
  local client = eq.get_entity_list():GetClientByID(e.caster_id);
 
  if (client.valid) then
    local dest_x, dest_y, dest_z, dest_h;
    if (eq.is_dragons_of_norrath_enabled()) then
      dest_x, dest_y, dest_z, dest_h = 460, 460, -86, 454; -- Zone: Lavastorm v1
    else
      dest_x, dest_y, dest_z, dest_h = 1389, 1014, 131, 301; -- Zone: Lavastorm v0
    end

    if (client:GetZoneID() == 27) then
      client:GMMove(dest_x, dest_y, dest_z, dest_h);
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
