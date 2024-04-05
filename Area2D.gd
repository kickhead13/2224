extends Area2D

@export var speed = 200
var velocity = Vector2.ZERO

var mouse_position = null
var screen_size #dimensiunea jocului

func _ready():
	screen_size = get_viewport_rect().size
	

#we normalise the velocity so that the movement on the diagonal axis is not faster than horizontal or vertical axis
#check if the player is moving and update the AnimatedSprite2D animation
#$ is the same as get_node("AnimatedSprite2D").play()
func _physics_process(delta):
	
	velocity = Vector2(0,0)
	
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_right2"):
		velocity.x += 1
	if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_left2"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up") || Input.is_action_pressed("move_up2"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down") || Input.is_action_pressed("move_down2"):
		velocity.y += 1
		
	velocity = velocity.normalized() * speed
	#update the position of the player, and clamp it so that it can not leave the screen
	position += velocity * delta
	position = position.clamp(Vector2.ZERO,screen_size)
	
