@tool
extends Sprite2D
@export_range(0,4) var direction:int = 0
@export var long : bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	updateSprite()
	pass # Replace with function body.

func updateSprite():
	frame = direction
	region_rect = Rect2(0,0,96,24 + int(long)*24)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateSprite()
	pass
