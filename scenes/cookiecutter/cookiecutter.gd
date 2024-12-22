extends Area2D
class_name CookieCutter

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if(body is Player):
		body.hp = 0
		body.visible = false
		$Sprite.frame = 1
	pass # Replace with function body.
