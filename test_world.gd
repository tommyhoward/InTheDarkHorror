extends Node3D

# 1. Drag your enemy.tscn file into this slot in the Inspector
@export var enemy_scene: PackedScene 

@onready var target = $Player

func _ready():
	# Spawn an enemy as soon as the game starts
	spawn_random_enemy()

func _process(delta):
	# This keeps telling all enemies where the player is
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)

func spawn_random_enemy():
	# 2. Find all Marker3D nodes that you put in the "spawner" group
	var spawn_points = get_tree().get_nodes_in_group("spawner")
	
	if spawn_points.size() > 0:
		# Pick one point at random
		var random_point = spawn_points.pick_random()
		
		# Create the enemy and place it at that point
		var enemy_instance = enemy_scene.instantiate()
		add_child(enemy_instance)
		enemy_instance.global_position = random_point.global_position
	else:
		print("Error: No nodes found in the 'spawner' group!")
