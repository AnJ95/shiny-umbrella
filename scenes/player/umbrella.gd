extends Area2D

const MIN_VELOCITY = 400

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var relative_angle = rad_to_deg((body.global_position - $"..".global_position).angle())
	var angle_diff = self.rotation_degrees - relative_angle
	if not $"..".umbrella_open and (-20 < angle_diff and angle_diff < 20) and $"..".velocity_last_frame > MIN_VELOCITY:
		body.break_pudding()
