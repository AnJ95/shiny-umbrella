extends CharacterBody2D

#Max speed of player, caps length of velocity each frame
const MAX_SPEED = SPEED*2.0
#Movement speed of player (maximum grounded speed)
const SPEED = 300.0

#MOVEMENT CONTROL CONSTS (grounded control factor = 1)
#Movement control while in air
const AIR_CONTROL = .8
#Movement control while in wind
const WIND_AIR_CONTROL = .6
#Factor for movement, altered if in air or in wind
var control_factor = 1.0

#JUMP VARIABLES
#Velocity applied on jump
const JUMP_VELOCITY = -300.0
#Jump startup time, can hold space to rise further
const JUMP_TIME = 0.2
#Current jump duration
var jump_timer = 0.0

#Time able to jump after leaving platform in delta
const COYOTE_TIME = 0.2
#Timer for counting time since leaving platform
var coyote_timer = 0.0

#INERTIA FACTORS - Fraction of Second (delta) to reach max speed or stop depending on control, ground, air
#Fraction of second that movement needs to be applied to reach full speed
const MOVEMENT_INERTIA_FACTOR = 10.0
#Fraction of second to stop on ground
const GROUND_INERTIA_FACTOR = 3.0
#Fraction of second to stop in air (if SPEED is reached)
const AIR_INERTIA_FACTOR = 1.0

#BOOLS
#Currently affected by wind
var in_wind = false
#Currently jumping
var jumping = false

var acceleration = Vector2(0.0,0.0)

#Damping of wind force each frame
const WIND_DAMPING = 0.2
#Wind force applied each frame (added to velocity)
var wind_force = Vector2(0.0,0.0)

#Angle of protection of umbrella in degrees
const UMBRELLA_PROTECTION_ANGLE = 30.0
var hp = 100.0
var umbrella_direction = Vector2(0.0,1.0)
#Umbrella Angle in degrees
var umbrella_angle = 0.0
#Umbrella open or not?
var umbrella_open = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	control_factor = 1.0
	if not is_on_floor():
		control_factor = AIR_CONTROL
		if in_wind:
			control_factor = WIND_AIR_CONTROL
		coyote_timer += delta
		velocity += get_gravity() * delta
	else:
		jumping = false
		coyote_timer = 0.0
	if jumping == true:
		jump_timer += delta
	else:
		jump_timer = 0.0
	# Handle jump.
	if Input.is_action_just_pressed("up"):
		if (is_on_floor() or coyote_timer <= COYOTE_TIME):
			jumping = true
			velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("up"):
		if(jumping == true and jump_timer <= JUMP_TIME):
			velocity.y -= get_gravity().y/2.0*delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x,direction * SPEED * control_factor, SPEED * control_factor*delta*MOVEMENT_INERTIA_FACTOR)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, SPEED*GROUND_INERTIA_FACTOR*delta)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED*AIR_INERTIA_FACTOR*delta)
	
	var winds = []
	#If no ground between player and umbrella
	if(!$umbrella/UmbrellaCast.is_colliding() and umbrella_open):
		winds = $umbrella/windable.get_wind_properties()
	#If not in wind, wind_force decays by damping factor each second
	if(winds.size() == 0): 
		wind_force = wind_force * (1.0-WIND_DAMPING)
		in_wind = false
	else:
		wind_force = Vector2(0.0,0.0)
		in_wind = true
	for wind in winds:
		var wind_direction = Vector2.from_angle(deg_to_rad(wind.angle))
		if(umbrella_direction.dot(wind_direction)>=0.4):
			wind_force += wind_direction*wind.strength
		else:
			acceleration = 0.0
	velocity += wind_force*SPEED*delta
	if(velocity.length()>=MAX_SPEED):
		velocity = velocity.normalized()*MAX_SPEED
	move_and_slide()

func applyRain(rain_angle):
	var angle_diff = wrapf(rain_angle - umbrella_angle,0.0,360.0)
	#if protected from rain
	if(angle_diff >= 90-UMBRELLA_PROTECTION_ANGLE && angle_diff <= 90+UMBRELLA_PROTECTION_ANGLE ):
		pass
	#not protected from rain
	else:
		hp -= 1.0

func _process(delta: float) -> void:
	umbrella_angle =  rad_to_deg((get_global_mouse_position() - self.position).angle())
	$umbrella.rotation_degrees = umbrella_angle
	umbrella_direction = (get_global_mouse_position() - self.position).normalized()
	
	# hand movement
	$umbrella/hands/left_hand.position.x = 11 + (cos($umbrella.rotation) + 1) * 8
	$umbrella/hands/right_hand.position.x = 27 - (cos($umbrella.rotation) + 1) * 8
	
	$umbrella/hands/left_hand.position.y = -3 + (cos($umbrella.rotation) + 1) * 3
	$umbrella/hands/right_hand.position.y = 3 + (cos($umbrella.rotation) + 1) * 3
	
	if Input.is_action_pressed("close_umbrella"):
		umbrella_open = false
		$umbrella/umbrella_sprite.play("closed")
	else:
		umbrella_open = true
		$umbrella/umbrella_sprite.play("open")
	
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
