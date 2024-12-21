extends PickupResource

@export var hp : int = 1
@export var uses : int = 1

func applyPickup(player:Player):
	if(player.hp < 10):
		player.hp += hp
		uses = uses-1
		print(player.hp)
		print("uses" + str(uses))
		if(uses == 0):
			delete_flag=true
		return false
	return true
