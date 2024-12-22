@tool
extends RigidBody2D
@export var apply_function : PickupResource = preload("res://scenes/pickup/health_pickup.tres") 
@export var texture : Texture2D
@export var active = true
@export var detect_player : bool = true
@export var cooldown : float = 0.2 
@export var animate = true
@export_range(0.0, 10.0,0.25) var time_out = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Pickup.apply_function = apply_function
	$Pickup.texture = texture
	$Pickup.active = active
	$Pickup.detect_player = detect_player
	$Pickup.cooldown = cooldown
	$Pickup.animate = animate
	$Pickup.time_out = time_out
	if !Engine.is_editor_hint():
		$Pickup.picked_up.connect(on_picked_up)
	pass # Replace with function body.

func on_picked_up():
	queue_free()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(texture):
		$Pickup.texture = texture
	if !Engine.is_editor_hint():
		var wind_force = Vector2(0.0,0.0)
		for wind in $windable.get_wind_properties():
			var wind_direction = Vector2.from_angle(deg_to_rad(wind.angle))
			wind_force += wind_direction*wind.strength
		apply_central_impulse(wind_force)
	pass
