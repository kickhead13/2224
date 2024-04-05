extends Node2D
var Player = preload("res://src/character_body_2d.tscn")
var Bullet = preload("res://src/bullet.tscn")
var player = Player.instantiate()

func _ready():
	player.position = Vector2(300,500)
	add_child(player)


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		var bullet = Bullet.instantiate()
		bullet.position = player.position
		bullet.rotation = player.rotation
		add_child(bullet)
	
