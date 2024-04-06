extends CharacterBody2D

const TYPE = "rec"
@onready var health = 10 
const REC_BOTTLE_TYPES_ARRAY = ["res://resources/recycle_bottle.png", "res://resources/recycle_banana.png","res://resources/recycle_battery.png","res://resources/recycle_can.png","res://resources/recycle_metal.png"]

var speed = 20
var player_position
var target_position
var player_to_follow = null
var rec_hoaming_distance = 300

func _ready():
		$Sprite2D.texture = load(REC_BOTTLE_TYPES_ARRAY[randi() % REC_BOTTLE_TYPES_ARRAY.size()])

func _physics_process(delta):
	if get_parent() != null && player_to_follow == null:
		player_to_follow = get_parent().get_node("Player")
	player_position = player_to_follow.position
	var distance = position.distance_to(player_position)
	if distance > rec_hoaming_distance:
		target_position = (player_position - position).normalized()
	else:
		target_position = -(player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
		velocity = Vector2(target_position * speed) 
		move_and_slide()


func hit(damage):
	health -= damage
	if health < 0:
		health = 0
	if health == 0:
		queue_free()
