extends Area2D

var velocity = Vector2(0,1)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += velocity

func _on_body_entered(body: Node2D) -> void:
	body.hit_by_rain()
	queue_free()
