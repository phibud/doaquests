sub EVENT_SPELL_EFFECT_TRANSLOCATE_COMPLETE
{
	my ($dest_x, $dest_y, $dest_z, $dest_h);
	if (quest::is_depths_of_darkhollow_enabled()) {
		($dest_x, $dest_y, $dest_z, $dest_h) = (-718, -53, 42, 0); # Zone: nektulos v1 small spires
	}
	else {
		($dest_x, $dest_y, $dest_z, $dest_h) = (-772, 432, 35, 35); # Zone: nektulos v0
	}

	if ($client->GetZoneID() == 25) {
		$client->GMMove($dest_x, $dest_y, $dest_z, $dest_h);
		if ($client->GetPetID()) {
			my $pet = $entity_list->GetMobByID($client->GetPetID());
			if ($pet) {
				$pet->GMMove($dest_x + 5, $dest_y + 5, $dest_z, $dest_h);
			}
		}
	}
	else {
		quest::movepc(25, $dest_x, $dest_y, $dest_z, $dest_h);
	}
}