extends StaticBody2D
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_milk_box_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/level_select/level_select.tscn")
