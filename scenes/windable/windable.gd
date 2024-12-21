extends Area2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func get_wind_properties():
	var winds = []
	for wind in get_overlapping_areas():
		print(wind.get_parent().get_wind())
		winds.append(wind.get_parent().get_wind())
	return winds
