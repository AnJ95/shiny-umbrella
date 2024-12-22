extends VBoxContainer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	# check buttons
	for i in range(get_children().size()):
		if get_children()[i].button_pressed:
			get_tree().change_scene_to_file(["res://scenes/levels/level_00.tscn",
											"res://scenes/levels/level_liran.tscn",
											"res://scenes/levels/level_l1.tscn"][i])
