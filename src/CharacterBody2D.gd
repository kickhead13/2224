extends CharacterBody2D

@export var speed = 400
var Bullet = preload("res://src/bullet.tscn")
var input = Vector2.ZERO
const acceleration = 1500
const friction = 300
var mouse_position = null
var screen_size #dimensiunea jocului

const EDGE_OFFSET = 30


func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	screen_size = get_viewport_rect().size
	player_movement(delta)
	if position.x < EDGE_OFFSET:
		position.x = EDGE_OFFSET
		velocity = Vector2.ZERO
	if position.y < EDGE_OFFSET:
		position.y = EDGE_OFFSET
		velocity = Vector2.ZERO
	if position.y > screen_size.y - EDGE_OFFSET:
		position.y = screen_size.y - EDGE_OFFSET
		velocity = Vector2.ZERO
	if position.x > screen_size.x - EDGE_OFFSET:
		position.x = screen_size.x - EDGE_OFFSET
		velocity = Vector2.ZERO

func get_input():
	input = Vector2(0,0)
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_right2"):
		input.x += 1
	if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_left2"):
		input.x -= 1
	if Input.is_action_pressed("move_up") || Input.is_action_pressed("move_up2"):
		input.y -= 1
	if Input.is_action_pressed("move_down") || Input.is_action_pressed("move_down2"):
		input.y += 1
	return input.normalized()


func player_movement(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	input = get_input()
	#partea care da slow down la caracter
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	#partea care da speed la caracter
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(speed)
	
	move_and_slide()
	
	#bullet spawn
	#if Input.is_action_just_pressed("shoot"):
		#shoot()

func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = transform
