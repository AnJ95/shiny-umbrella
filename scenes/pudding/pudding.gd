extends StaticBody2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func break_pudding():
	$pudding_particles.emitting = true
	$pudding_sprite.visible = false
	$pudding_shape.set_deferred("disabled", true)

func _on_pudding_particles_finished() -> void:
	queue_free()
