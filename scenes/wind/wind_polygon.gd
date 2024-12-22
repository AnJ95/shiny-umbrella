@tool
extends Polygon2D
class_name WindPolygon

@export_range(0, 360, 1, "degrees") var angle = 0.0
@export var strength: float = 5 

# Called when the node enters the scene tree for the first time.
func _ready():
	update_values()
	pass # Replace with function body.

func get_wind():
	return WindProperties.new(angle, strength)
	
class WindProperties:
	var angle
	var strength
	
	func _init(angle, strength):
		self.angle = angle
		self.strength = strength
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		update_values()
	pass

func update_values():
	$WindArea/CollisionPolygon.polygon = polygon
	var minX = 0.0
	var minY = 0.0
	var maxX = 0.0
	var maxY = 0.0
	for v in polygon:
		if v.x <= minX:
			minX = v.x
		if v.y <= minY:
			minY = v.y
		if v.x >= maxX:
			maxX = v.x
		if v.y >= maxY:
			maxY = v.y
	$WindArea/DebugHelper.position = Vector2(minX + (maxX-minX)/2.0, minY + (maxY-minY)/2.0)
	$WindArea/DebugHelper.global_rotation_degrees = angle
	$WindArea/DebugHelper.scale = Vector2((maxX-minX+maxY-minY)/2.0/10.0,(maxX-minX+maxY-minY)/2.0/10.0)
	material.set("shader_parameter/angle", angle);
	material.set("shader_parameter/speed", strength * 0.2);
	
