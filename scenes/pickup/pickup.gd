extends Area2D
class_name Pickup

	
@export var apply_function : PickupResource = preload("res://scenes/pickup/health_pickup.tres") 
@export var texture : ImageTexture
@export var detect_player : bool = true
@export_range(0.0, 10.0,0.25) var time_out = 0.0
var timer:Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = texture
	if(!apply_function):
		print("no apply function for pickup")
		queue_free()
	if(time_out):
		timer = Timer.new()
		timer.wait_time=time_out
		timer.start()
		timer.connect("timeout",on_timer_timeout())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_timer_timeout():
	queue_free()
	pass

func _on_body_entered(body):
	if(body is Player):
		await(apply_function.applyPickup(body))
		queue_free()
	pass # Replace with function body.
