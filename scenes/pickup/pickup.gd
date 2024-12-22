@tool
extends Area2D
class_name Pickup
	
@export var apply_function : PickupResource = preload("res://scenes/pickup/health_pickup.tres") 
@export var texture : Texture2D
@export var active = true
@export var detect_player : bool = true
@export var cooldown : float = 0.2 
@export var animate = true
@export_range(0.0, 10.0,0.25) var time_out = 0.0
var time_passed = 0.0
var timer:Timer
var cooldownTimer : Timer
signal picked_up
# Called when the node enters the scene tree for the first time.
func _ready():
	if(texture):
		$Sprite2D.texture = texture
		$Sprite2D.scale.x = 24/texture.get_size().x
		$Sprite2D.scale.y = 24/texture.get_size().y
	if !Engine.is_editor_hint():
		if(!apply_function):
			print("no apply function for pickup")
			queue_free()
		if(cooldown):
			cooldownTimer = Timer.new()
			add_child(cooldownTimer)
			cooldownTimer.wait_time = cooldown
			cooldownTimer.timeout.connect(on_cooldown_timeout)
		if(time_out):
			timer = Timer.new()
			add_child(timer)
			timer.wait_time=time_out
			timer.timeout.connect(on_timer_timeout)
			timer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(texture):
		$Sprite2D.texture = texture
		$Sprite2D.scale.x = 24/texture.get_size().x
		$Sprite2D.scale.y = 24/texture.get_size().y
	if !Engine.is_editor_hint():
		if(animate):
			time_passed+=delta
			$Sprite2D.position.y=sin(time_passed)*4-4
		if(apply_function.delete_flag):
			queue_free()
		if(monitoring):
			for body in get_overlapping_bodies():
				apply(body)
	pass

func on_timer_timeout():
	queue_free()
	pass

func on_cooldown_timeout():
	setActive(true)
	pass	
	
func setActive(active):
	monitoring = active
	pass
	
func apply(body):
	if(body is Player and detect_player):
		emit_signal("picked_up")
		setActive(apply_function.applyPickup(body))
		if(cooldown):
			cooldownTimer.start()
	pass
	
func _on_body_entered(body):
	
	pass # Replace with function body.
