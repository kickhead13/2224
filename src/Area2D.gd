extends Area2D
"""
@export var speed = 200
var input = Vector2.ZERO
var velocity = 0
const acceleration = 1500
const friction = 600
var mouse_position = null
var screen_size #dimensiunea jocului

func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	player_movement(delta)


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
		
	velocity = velocity.normalized() * speed
	#update the position of the player, and clamp it so that it can not leave the screen
	position += velocity * delta
	position = position.clamp(Vector2.ZERO,screen_size)"""

func _ready():
	input_pickable = true


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouseleft"): # set this up in project settings
		print("lesgooo")


func _on_input_event(viewport, event, shape_idx):
	if event.button_mask == 1:# and type_string(typeof(event)) == "InputEventMouseButton":
		if get_parent() != null and get_parent().get_parent() != null:
			get_parent().get_parent().exit_status = "click"
	
