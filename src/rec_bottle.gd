extends CharacterBody2D

const TYPE = "rec"
@onready var health = 10 
const rec_bottle_types_array = ["res://resources/recycle_bottle.png"]

var speed = 20
var player_position
var target_position
var player_to_follow = null

func _ready():
		$Sprite2D.texture = load(rec_bottle_types_array[randi() % rec_bottle_types_array.size()])

func _physics_process(delta):
	if get_parent() != null && player_to_follow == null:
		player_to_follow = get_parent().get_node("Player")
	player_position = player_to_follow.position
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
