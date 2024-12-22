extends TextureRect

@onready var root_position = self.position

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	self.position.y = root_position.y + sin(Time.get_unix_time_from_system()+self.position.x) * 20
