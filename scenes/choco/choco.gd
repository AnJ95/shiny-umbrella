extends TileMapLayer

const TRIGGER_ANIM_NAME = "trigger"
const GRAVITY = 9
const DESPAWN_Y = 10000

var is_triggered = false
var is_falling = false
var velocity = Vector2.ZERO

func _ready():
	position = Vector2.ZERO
	
func trigger():
	if not is_triggered:
		$AnimationPlayer.play(TRIGGER_ANIM_NAME)
		is_triggered = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == TRIGGER_ANIM_NAME:
		start_falling()

func start_falling():
	is_falling = true

func _physics_process(delta: float) -> void:
	if is_falling:
		velocity += Vector2.DOWN * GRAVITY * delta
		position += Vector2.DOWN * velocity * delta
		if position.y > DESPAWN_Y:
			queue_free()
