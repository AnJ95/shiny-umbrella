extends Area2D

const RAINDROP_LIFETIME = 5.0

var velocity = Vector2(0,1)

func _ready() -> void:
	$Timer.wait_time=RAINDROP_LIFETIME
	$Timer.start()
	pass

func _process(delta: float) -> void:
	position += velocity

func _on_body_entered(body: Node2D) -> void:
	set_deferred("monitoring", false)
	self.visible = false
	body.hit_by_rain()
	$drop_sound.play()

func _on_area_entered(area: Area2D) -> void:
	set_deferred("monitoring", false)
	self.visible = false
	$drop_sound.play()

func _on_drop_sound_finished() -> void:
	queue_free()

func _on_timer_timeout():
	queue_free()
