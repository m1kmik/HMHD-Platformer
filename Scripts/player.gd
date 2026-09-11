extends CharacterBody2D

@onready var sprite2d = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400

#var dash = 5000
#var airdashable: bool = true
var gravity_normal = 14
var gravity_wall = 5
var wall_push_force = 100

var wall_contact_coyote: float = 0.0
const WALL_CONTACT_COYOTE_TIME: float = 0.2

var wall_jump_lock: float = 0.0
const WALL_JUMP_LOCK_TIME: float = 0.05

var look_dir_x: int = 1

func _physics_process(delta):
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if wall_jump_lock > 0:
		wall_jump_lock -= delta
		velocity.x = -direction * SPEED*0.5
	elif direction: velocity.x = direction * SPEED
	else: velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#if airdashable:
		#if !is_on_floor():
			#if velocity.x > 0 && Input.is_key_pressed(KEY_Z):
					#velocity.x += dash
					#velocity.y=0
					#airdashable = false
			#elif velocity.x < 0 && Input.is_key_pressed(KEY_Z):
					#velocity.x -= dash
					#velocity.y=0
					#airdashable = false
				
	
	if is_on_floor() or wall_contact_coyote > 0:
		#airdashable = true
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			if wall_contact_coyote > 0:
				velocity.x = -look_dir_x * wall_push_force
				wall_jump_lock = WALL_JUMP_LOCK_TIME
				velocity.y = JUMP_VELOCITY/2

	if (velocity.y > 0 && is_on_wall() && velocity.x !=0) :
			look_dir_x = sign(velocity.x)
			wall_contact_coyote = WALL_CONTACT_COYOTE_TIME
			velocity.y += gravity_wall
	else:
		wall_contact_coyote -= delta
		velocity.y += gravity_normal
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	
	
	
	if direction > 0: sprite2d.flip_h = false
	elif direction < 0: sprite2d.flip_h = true
	
	move_and_slide()
	
func _input(event: InputEvent):
	if (event.is_action_pressed("ui_down") && is_on_floor()):
		position.y += 1
