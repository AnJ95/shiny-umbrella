extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#Safe area from rain
const rainProtectionAngle = 30.0
var hp = 100.0
var umbrella_direction = Vector2(0.0,1.0)
#Umbrella Angle in degrees
var umbrellaAngle = 0.0
var acceleration = Vector2(0.0,0.0)
var damping = 0.5

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var winds = $umbrella/windable.get_wind_properties()
	for wind in winds:
		var wind_direction = Vector2.from_angle(deg_to_rad(wind.angle))
		if(umbrella_direction.dot(wind_direction)>=0):
			print("in wind")
			acceleration = wind_direction*wind.strength
		else:
			acceleration = wind_direction*wind.strength/10.0
	velocity += acceleration
	move_and_slide()
	acceleration = acceleration * damping

func applyRain(rainAngle):
	var angleDiff = wrapf(rainAngle - umbrellaAngle,0.0,360.0)
	#if protected from rain
	if(angleDiff >= 90-rainProtectionAngle && angleDiff <= 90+rainProtectionAngle ):
		pass
	#not protected from rain
	else:
		hp -= 1.0
	#print(hp)
pass

func _process(delta: float) -> void:
	umbrellaAngle =  rad_to_deg((get_global_mouse_position() - self.position).angle())
	$umbrella.rotation_degrees = umbrellaAngle
	umbrella_direction = (get_global_mouse_position() - self.position).normalized()
	var a = 0
	
	for i in $umbrella/windable.get_wind_properties():
		a += i.strength
	
	print(a)
