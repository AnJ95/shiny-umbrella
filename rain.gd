@tool
extends Node2D
class_name Rain
@export var size = Vector2i(20,20)
@export var strength : float
@export_range(5,20) var tick_rate = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RainArea/CollisionShape2D.shape.size = size
	$RainArea.position.y = size.y/2.0
	$RainArea/CollisionShape2D/GPUParticles2D.process_material.emission_shape_scale.x = size.x/2.0
	$RainArea/CollisionShape2D/GPUParticles2D.set_visibility_rect(Rect2(-size.x/2.0,0.0,size.x,size.y))
	pass


func _on_timer_timeout():
	var areas = $RainArea.get_overlapping_areas()
	for area in areas:
		if area.has_method("applyRain"):
			area.applyRain()
	pass # Replace with function body.
