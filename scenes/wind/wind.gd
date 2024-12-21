@tool
extends Node2D
class_name Wind
@export var size =Vector2i(20,20)
@export_range(0, 360, 1, "degrees") var angle = 0.0
@export var strength : float = 5 

# Called when the node enters the scene tree for the first time.
func _ready():
	update_values()
	pass # Replace with function body.

func get_wind():
	return WindProperties.new(angle, strength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		update_values()
	
class WindProperties:
	var angle
	var strength
	
	func _init(angle, strength):
		self.angle = angle
		self.strength = strength

func update_values():
	$WindArea/CollisionShape2D.shape.size = size
	$WindArea.position.x = size.x/2.0
	$WindArea/DebugHelper.global_rotation_degrees = angle
	$WindArea/DebugHelper.scale = Vector2((size.x+size.y/2.0)/10.0,(size.x+size.y/2.0)/10.0)
