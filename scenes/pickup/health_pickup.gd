extends PickupResource

@export var hp : int = 1

func applyPickup(player:Player):
	player.hp += hp
	pass
