extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_wind_properties():
	var winds = []
	for wind in get_overlapping_areas():
		winds.append(wind.get_wind())
	return winds
