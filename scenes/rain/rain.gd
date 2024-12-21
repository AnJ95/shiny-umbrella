@tool
extends Node2D
class_name Rain
@export var size = Vector2i(20,20)
@export var strength : float
@export_range(5,20) var tick_rate = 10
@export_range(0, 360, 1, "degrees") var angle = 0.0
@export var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$RainArea/Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RainArea/CollisionShape2D.shape.size = size
	$RainArea.position.y = size.y/2.0
	$RainArea/CollisionShape2D/GPUParticles2D.process_material.emission_shape_scale.x = size.x/2.0
	$RainArea/CollisionShape2D/GPUParticles2D.set_visibility_rect(Rect2(-size.x/2.0,0.0,size.x,size.y))
	$RainArea/CollisionShape2D/GPUParticles2D.emitting = active
	$RainArea.global_rotation_degrees = angle
	$RainArea/DebugHelper.position.y = 0
	pass


func _on_timer_timeout():
	#only run ingame
	if not Engine.is_editor_hint():
		var bodies = $RainArea.get_overlapping_bodies()
		for body in bodies:
			if body.has_method("applyRain"):
				body.applyRain(angle)
		var areas = $RainArea.get_overlapping_areas()
		for area in areas:
			if area.has_method("applyRain"):
				area.applyRain(angle)
		$RainArea/Timer.start()
	pass # Replace with function body.
