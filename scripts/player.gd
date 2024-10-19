extends CharacterBody2D

signal took_damage # custom signal

var speed = 300
var rocket_scene = preload("res://scenes/rocket.tscn")
@onready var rocket_container = $RocketContainer #same as get_node("RocketContainer")
@onready var rocket_fired_sound = $RocketFiredSound

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed

	move_and_slide()
	var screen_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2(0, 0), screen_size)

# Creates an instance of the rocket scene, sets it as a child of the player
# creates it at the player location then adds trajectory to the rocket
func shoot():
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	rocket_fired_sound.play()

func take_damage():
	emit_signal('took_damage')
	
func die():
	queue_free()
