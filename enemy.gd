extends CharacterBody3D

@onready var nav = $NavigationAgent3D
var speed = 3.5
var gravity = 9.8

func _process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
		
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	
	# 1. Calculate the direction to the next path point
	var new_velocity = (next_location - current_location).normalized() * speed
	
	# 2. Make the character face the direction they are moving
	if new_velocity.length() > 0.1: # Only rotate if we are actually moving
		var look_target = current_location + new_velocity
		look_target.y = current_location.y # Keep the 'look target' at our height so we don't tilt
		look_at(look_target, Vector3.UP)
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()

func target_position(target):
	nav.target_position = target
