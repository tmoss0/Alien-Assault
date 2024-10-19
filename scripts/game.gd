extends Node2D

var lives = 3
var score = 0
@onready var player = $Player # reference to player that is in the Scene
@onready var hud = $UI/HUD # gets the child scene of the UI node
@onready var ui = $UI
var game_over_scene = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_deathzone_area_entered(area):
	area.queue_free()

func _on_player_took_damage():
	lives -= 1
	hud.set_lives_label(lives)
	if lives == 0:
		player.die()
		await get_tree().create_timer(1).timeout
		var game_over_screen = game_over_scene.instantiate()
		game_over_screen.set_score(score)
		ui.add_child(game_over_screen)

# Adds enemies as childs of the Game node instead of the EnemySpawner node
func _on_enemy_spawner_enemy_spawn(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
