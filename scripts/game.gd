extends Node2D

var lives = 3
var score = 0
@onready var player = $Player # reference to player that is in the Scene
@onready var hud = $UI/HUD # gets the child scene of the UI node

func _ready():
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_deathzone_area_entered(area):
	area.die()

func _on_player_took_damage():
	lives -= 1
	hud.set_lives_label(lives)
	if lives == 0:
		print("Game Over")
		player.die()

# Adds enemies as childs of the Game node instead of the EnemySpawner node
func _on_enemy_spawner_enemy_spawn(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
