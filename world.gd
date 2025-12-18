extends Node3D

# Drag your enemy.tscn file into this slot in the Inspector
@export var enemy_scene: PackedScene 

@onready var target = $Player

func _ready():
	# 1. Find the Area3D safely regardless of the exact path
	var player_area = target.find_child("Area3D", true, false)
	
	if player_area:
		player_area.body_entered.connect(_on_player_area_body_entered)
		print("Area3D found and connected!")
	else:
		print("ERROR: Could not find Area3D inside the Player!")
	
	# Spawn the first enemy
	spawn_random_enemy()

func _process(_delta):
	# Tell enemies where the player is
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)

func spawn_random_enemy():
	var spawn_points = get_tree().get_nodes_in_group("spawner")
	
	if spawn_points.size() > 0:
		var random_point = spawn_points.pick_random()
		var enemy_instance = enemy_scene.instantiate()
		
		# Ensure the enemy is added to the scene
		add_child(enemy_instance)
		enemy_instance.global_position = random_point.global_position
	else:
		print("No nodes found in 'spawner' group!")

# This is the function that was causing the error
func _on_player_area_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free() # The enemy dies
		spawn_random_enemy() # A new one spawns
