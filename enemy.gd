extends CharacterBody3D

@onready var nav: NavigationAgent3D = $NavigationAgent3D

var speed: float = 2.0
var gravity: float = 20.0 

func _ready():


	floor_max_angle = deg_to_rad(45.0) 
	floor_snap_length = 0.3


	nav.path_desired_distance = 0.5
	nav.target_desired_distance = 0.5

func _physics_process(delta):

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:

		velocity.y = -5.0


	var next_location = nav.get_next_path_position()
	var current_location = global_position
	

	var direction = (next_location - current_location)
	direction.y = 0 
	direction = direction.normalized()
	

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed


	if direction.length() > 0.1:
		var look_target = current_location + direction
		look_at(look_target, Vector3.UP)
	

	move_and_slide()

func target_position(target: Vector3):
	nav.target_position = target
