@tool
extends TileMap
@export_range(5,20) var tick_rate = 10
@export_range(0, 360, 1, "degrees") var angle = 0.0
@export var active = false
@onready var raindrop_scene = preload("res://scenes/raindrop/raindrop.tscn")
@export var raindrop_lifetime = 2.0
const MAX_RAINDROPS :int = 8000
var positions = []
# Called when the node enters the scene tree for the first time.
func _ready():
	while($Raindrops.get_child_count()>0):
		$Raindrops.remove_child($Raindrops.get_child(0))
	if !Engine.is_editor_hint():
		$Timer.start()
	$Timer.wait_time=1.0/tick_rate
	for cell in get_used_cells(0):
		var localPosition = map_to_local(cell)
		positions.push_back(localPosition)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active):
		if($Timer.is_stopped()):
			$Timer.start()
	pass


func _on_timer_timeout():
	var raindrop = raindrop_scene.instantiate()
	var rng = RandomNumberGenerator.new()
	var raindrop_timer = Timer.new()
	#raindrop_timer.wait_time = RAINDROP_LIFETIME
	raindrop.position = positions[randi_range(0,positions.size()-1)]
	if($Raindrops.get_child_count()<=MAX_RAINDROPS):
		$Raindrops.add_child(raindrop)
	pass # Replace with function body.
