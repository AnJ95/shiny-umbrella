extends Area2D
class_name Checkpoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_spawn_position():
	return $SpawnPosition.global_position

func _on_body_entered(body):
	if(body is Player):
		body.set_checkpoint(self)
	pass # Replace with function body.
