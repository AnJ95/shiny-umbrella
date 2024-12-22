extends Area2D
class_name CookieCutter

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in get_overlapping_bodies():
		if(body is Player):
			if(body.get_node("InvulnerabilityBuff")):
				return
			else:
				body.die()
				$Sprite.frame = 1
	pass
