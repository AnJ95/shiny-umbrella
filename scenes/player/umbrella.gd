extends Area2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var relative_angle = rad_to_deg((body.position - $"..".position).angle())
	var angle_diff = self.rotation_degrees - relative_angle
	if not $"..".umbrella_open and (-20 < angle_diff and angle_diff < 20) and $"..".velocity_last_frame > 10:
		body.queue_free()
	print("rel: ", relative_angle, " diff: ", angle_diff)
