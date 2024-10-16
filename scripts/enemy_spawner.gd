extends Node2D

signal enemy_spawn(enemy_instance)
var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var spawn_positions = $SpawnPositions # references the node inside of the scene
	
func _on_timer_timeout():
	spawn_enemy()
	
func spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children() # returns an array
	var random_spawn_position = spawn_positions_array.pick_random() # chooses random element from the array (SpawnPos_01 - SpawnPos_06)
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn_position.global_position
	emit_signal("enemy_spawn", enemy_instance)
	#add_child(enemy_instance)
