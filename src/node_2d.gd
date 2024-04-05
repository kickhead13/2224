extends Node2D
var Player = preload("res://src/character_body_2d.tscn")
var BasicBullet = preload("res://src/bullet.tscn")
var Bullet = BasicBullet
var Bullet_Display = preload("res://src/bullet_display.tscn")
var Rec_Bottle = preload("res://src/rec_bottle.tscn")
var Waste_Bottle = preload("res://src/waste_bottle.tscn")
var player = Player.instantiate()
var bullet_displays = []
const BULLET_ROW = 30
const BULLET_COLUMN = 30
const BULLET_COLUMN_OFFSET = 50

func _ready():
	var rec_bottle = Waste_Bottle.instantiate()
	rec_bottle.position = Vector2(300, 400)
	add_child(rec_bottle)
	
	rec_bottle = Waste_Bottle.instantiate()
	rec_bottle.position = Vector2(700, 300)
	add_child(rec_bottle)
	
	rec_bottle = Waste_Bottle.instantiate()
	rec_bottle.position = Vector2(1200, 900)
	add_child(rec_bottle)
	
	rec_bottle = Rec_Bottle.instantiate()
	rec_bottle.position = Vector2(1200, 100)
	add_child(rec_bottle)
	
	player.position = Vector2(300,500)
	add_child(player)
	for i in range(player.MAX_INITIAL_BULLETS / 2):
		var bullet_display=Bullet_Display.instantiate()
		add_child(bullet_display)
		bullet_display.position.y = BULLET_ROW
		bullet_display.position.x = BULLET_COLUMN + BULLET_COLUMN_OFFSET * i
		bullet_displays.push_back(bullet_display)
		

func refresh_bullet_display():
	for bullet_display in bullet_displays:
		if bullet_display != null:
			bullet_display.queue_free()
	for i in range((player.bullet_count+1) / 2):
		var bullet_display=Bullet_Display.instantiate()
		add_child(bullet_display)
		bullet_display.position.y = BULLET_ROW
		bullet_display.position.x = BULLET_COLUMN + BULLET_COLUMN_OFFSET * i
		bullet_displays.push_back(bullet_display)

func _process(delta):
	refresh_bullet_display()
	if Input.is_action_just_pressed("shoot") && player.bullet_count > 0:
		player.bullet_count -= 1
		var bullet = Bullet.instantiate()
		bullet.position = player.position
		bullet.rotation = player.rotation
		add_child(bullet)
	
