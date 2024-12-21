extends Resource
class_name PickupResource
#if true, will be deleted
var delete_flag = false
#return false to disable hitbox
func applyPickup(player:Player):
	return false
