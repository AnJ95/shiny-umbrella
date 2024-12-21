extends Sprite2D

func _ready():
	var viewport_size = get_viewport_rect().size
	if texture:
		var texture_size = texture.get_size()
		var scale_factor = viewport_size.x / texture_size.x
		scale = Vector2(scale_factor, scale_factor)
		position = Vector2(viewport_size.x / 2, 0)
