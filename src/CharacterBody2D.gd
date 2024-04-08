extends CharacterBody2D

@export var speed = 400
var Bullet = preload("res://src/bullet.tscn")
var dead_sound = preload("res://resources/sounds/Game Over.wav")
var over_sound = null
var input = Vector2.ZERO
var mouse_position = null
var screen_size #dimensiunea jocului
var bullet_count = 10
var EDGE_OFFSET = 60
var hearts_count = 0
var dash_timer = 0

const MAX_INITIAL_HEARTS = 10
var bdamage = 5

var max_health = 10
var health = max_health
var inverse_control = 1
var mode = "nothing"
var MAX_INITIAL_BULLETS = 10
var friction = 300
var heat = 0

const OVERHEAT = 20

const acceleration = 1500
const MALWARE = [
	"invers_control",
	"zero_bullets",
	"refill_hp",
	"refill_bullet",
	"double_score",
	"more_max_bullet",
	"lower_speed",
	"higher_damage",
	"extra_health"
]
var param1 = 0
var label_timer = 180

func change_label(string):
	if get_parent() != null and get_parent().get_child(2):
		get_parent().get_child(2).text = string

func handle_label():
	if label_timer > 0:
		if mode != "nothing":
			change_label(mode)
		label_timer -= 0
	else:
		change_label(" ")

func handle_mode():
	if mode != "nothing":
		label_timer = 180
	if mode == "invers_control":
		inverse_control *= -1
	elif mode == "zero_bullets":
		bullet_count = 0
	elif mode == "refill_hp":
		health = max_health
	elif mode == "refill_bullet":
		bullet_count = MAX_INITIAL_BULLETS
	elif mode == "double_score" and get_parent() != null:
		get_parent().score *= 2
	elif mode == "more_max_bullet":
		MAX_INITIAL_BULLETS += param1
		bullet_count = MAX_INITIAL_BULLETS
	elif mode == "lower_speed":
		if speed > 150:
			speed /= param1
	elif mode == "extra_health":
		max_health += param1
		health = max_health
	elif mode == "higher_damage":
		bdamage += param1
	
	mode = "nothing"

func _ready():
	hearts_count = max_health
	screen_size = get_viewport_rect().size
	if get_parent() != null:
		EDGE_OFFSET = get_parent().CHARACTER_EDGE_OFFSET

func _physics_process(delta):
	handle_label()
	handle_mode()
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
	input = Vector2.ZERO
	if inverse_control == 1:
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_right2"):
			input.x += 1
		if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_left2"):
			input.x -= 1
		if Input.is_action_pressed("move_up") || Input.is_action_pressed("move_up2"):
			input.y -= 1
		if Input.is_action_pressed("move_down") || Input.is_action_pressed("move_down2"):
			input.y += 1
	else:
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_right2"):
			input.x -= 1
		if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_left2"):
			input.x += 1
		if Input.is_action_pressed("move_up") || Input.is_action_pressed("move_up2"):
			input.y += 1
		if Input.is_action_pressed("move_down") || Input.is_action_pressed("move_down2"):
			input.y -= 1
	return input.normalized()

func player_movement(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	if dash_timer != 0:
		dash_timer -= 1
	
	if Input.is_action_just_pressed("dash") and dash_timer == 0:
		var direction = mouse_position - position
		velocity += (direction / 20 * acceleration * delta)
		dash_timer = 120
	else:
	
		input = get_input()
			#partea care da slow down la caracter
		if input == Vector2.ZERO:
			$AnimatedSprite2D.animation = "idle_airship"
			$AnimatedSprite2D.stop()
			if velocity.length() > (friction * delta):
				velocity -= velocity.normalized() * (friction * delta)
			else:
				velocity = Vector2.ZERO
			#partea care da speed la caracter
		else:
			if $AnimatedSprite2D.animation != "moving_airship":
				$AnimatedSprite2D.animation = "moving_airship"
				$AnimatedSprite2D.play()
			velocity += (input * acceleration * delta)
			velocity = velocity.limit_length(speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("bullet_count_reset"):
		bullet_count=MAX_INITIAL_BULLETS
	

func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = transform

func hit(damage):
	health -= damage
	if health <= 0:
		over_sound = AudioStreamPlayer.new()
		over_sound.stream = dead_sound
		over_sound.autoplay = true
		add_child(over_sound)
		OS.delay_msec(1500)
		get_tree().quit()

func _on_area_2d_area_entered(area):
	if area.is_in_group("recycle") :
		if get_parent() != null:
			get_parent().rec_bottles_contor -= 1
		area.get_parent().queue_free()
		bullet_count = MAX_INITIAL_BULLETS
	if area.is_in_group("waste"):
		hit(area.get_parent().damage)
		area.get_parent().velocity = velocity
		velocity = Vector2.ZERO
