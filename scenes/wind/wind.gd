@tool
extends Node2D
class_name Wind
@export var size =Vector2i(20,20)
@export_range(0, 360, 1, "degrees") var angle = 0.0
@export var strength : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getWind():
	return [angle,strength]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$WindArea/CollisionShape2D.shape.size = size
	$WindArea.position.x = size.x/2.0
	$WindArea/DebugHelper.global_rotation_degrees = angle
	pass
