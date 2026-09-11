extends Node2D
const SPEED = 60

var direction = 1

@onready var raycast_right = $RayCastRight
@onready var raycast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if raycast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	if raycast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	
		
	position.x += direction * SPEED * delta
