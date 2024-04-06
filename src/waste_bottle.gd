extends CharacterBody2D

var speed = 50
var health = 10
var damage = 1
var inflate_timer = INFLATE_OFFSET
var player_position
var target_position
var player_to_follow = null
var score = 20
var NORMAL_SCALE = 1
var SCALE_OFFSET = NORMAL_SCALE + NORMAL_SCALE * 0.2


const TYPE = "waste"
const INFLATE_OFFSET = 5
const friction = 300
const BOUNCE_SPEED = 200
const WASTE_BOTTLE_TYPES_ARRAY = ["res://resources/waste_bottle.png","res://resources/waste_banana.png","res://resources/waste_battery.png","res://resources/waste_can.png","res://resources/waste_metal.png"]

func _ready():
	$Sprite2D.texture = load(WASTE_BOTTLE_TYPES_ARRAY[randi() % WASTE_BOTTLE_TYPES_ARRAY.size()])



func _on_body_entered(body):
	pass
	#print("test")

func _physics_process(delta):
	if get_parent() != null && player_to_follow == null:
		player_to_follow = get_parent().get_node("Player")
	player_position = player_to_follow.position
	target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
		velocity = Vector2(target_position * speed) 
		move_and_slide()
	
	if inflate_timer > 0:
		inflate_timer -= 1
	if inflate_timer == 0 and scale != Vector2(NORMAL_SCALE,NORMAL_SCALE):
		scale = Vector2(NORMAL_SCALE, NORMAL_SCALE)
	bottle_movement(delta)

func bottle_movement(delta):
	if velocity.length() > (friction * delta):
		velocity -= velocity.normalized() * (friction * delta)
	else:
		velocity = Vector2.ZERO
	#partea care da speed la caracte
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		hit(area.get_parent().damage)
		var dirx = area.get_parent().transform.x #	 [x = ... , y = ...]
		velocity = Vector2(dirx.x*BOUNCE_SPEED,dirx.y*BOUNCE_SPEED)
		area.get_parent().queue_free()
		scale = Vector2(NORMAL_SCALE + NORMAL_SCALE * 0.2, NORMAL_SCALE + NORMAL_SCALE * 0.2)
		inflate_timer = INFLATE_OFFSET
	

func hit(damage):
	health -= damage
	if health < 0:
		health = 0
	if health == 0:
		get_parent().score += score
		queue_free()
