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
var number_of_mobs = 20
const CHARACTER_EDGE_OFFSET = 60
const MAX_REC_BOTTLES = 5
var screen_size = 0


func spawn_mobs():
	screen_size = get_viewport_rect().size
	var rec_bottles_contor = 0
	
	for i in number_of_mobs:
		var choose_mob = randi() % 2 + 1
		if(choose_mob == 1 && rec_bottles_contor != MAX_REC_BOTTLES):
			rec_bottles_contor += 1
			var rec_bottle = Rec_Bottle.instantiate()
			rec_bottle.position = Vector2(randf_range(60, screen_size.x - CHARACTER_EDGE_OFFSET), randf_range(60, screen_size.y-CHARACTER_EDGE_OFFSET))
			add_child(rec_bottle)
		else:
			var waste_bottle = Waste_Bottle.instantiate()
			waste_bottle.position = Vector2(randf_range(60, screen_size.x - CHARACTER_EDGE_OFFSET), randf_range(60, screen_size.y - CHARACTER_EDGE_OFFSET))
			add_child(waste_bottle)


func _ready():
	spawn_mobs()
	
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
	screen_size = get_viewport_rect().size
	refresh_bullet_display()
	if Input.is_action_just_pressed("shoot") && player.bullet_count > 0:
		player.bullet_count -= 1
		var bullet = Bullet.instantiate()
		bullet.position = player.position
		bullet.rotation = player.rotation
		add_child(bullet)
	
	
