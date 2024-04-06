extends Node2D
var Player = preload("res://src/character_body_2d.tscn")
var BasicBullet = preload("res://src/bullet.tscn")
var Bullet = BasicBullet
var Bullet_Display = preload("res://src/bullet_display.tscn")
var Rec_Bottle = preload("res://src/rec_bottle.tscn")
var Waste_Bottle = preload("res://src/waste_bottle.tscn")
var Digit = preload("res://src/digit.tscn")
var player = Player.instantiate()
var bullet_displays = []
var score = 234
var digits = []
var screen_size = 0
var last_screen_size = Vector2.ZERO
var last_score = 234

const BULLET_ROW = 30
const BULLET_COLUMN = 30
const BULLET_COLUMN_OFFSET = 50
const SCORE_EDGE_OFFSET = 18
const NUM_OF_DIGITS = 6
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
	screen_size = get_viewport_rect().size
	
	spawn_mobs()
	
	player.position = Vector2(300,500)
	add_child(player)
	for i in range(player.MAX_INITIAL_BULLETS / 2):
		var bullet_display=Bullet_Display.instantiate()
		add_child(bullet_display)
		bullet_display.position.y = BULLET_ROW
		bullet_display.position.x = BULLET_COLUMN + BULLET_COLUMN_OFFSET * i
		bullet_displays.push_back(bullet_display)
	
	for iter in range(NUM_OF_DIGITS):
		var digit = Digit.instantiate()
		digit.position = Vector2(screen_size.x-SCORE_EDGE_OFFSET * (iter + 1), SCORE_EDGE_OFFSET)
		digits.push_back(digit)
		add_child(digit)

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

func replace(digits, screen_size):
	var iter = 0
	for digit in digits:
		digit.position = Vector2(screen_size.x-SCORE_EDGE_OFFSET * (iter + 1), SCORE_EDGE_OFFSET)
		iter += 1

func score_vect(digits):
	var sc = score
	var vect = []
	while sc != 0:
		vect.push_front(sc % 10)
		sc /= 10
	return vect

func update_score_digits(digits):
	var digs = score_vect(digits)
	var iter = len(digs) - 1
	for dig in digs:
		digits[iter].set_val(dig)
		iter -= 1

func _process(delta):
	screen_size = get_viewport_rect().size
	
	if last_score != score:
		update_score_digits(digits)

	refresh_bullet_display()
	if Input.is_action_just_pressed("shoot") && player.bullet_count > 0:
		player.bullet_count -= 1
		var bullet = Bullet.instantiate()
		bullet.position = player.position
		bullet.rotation = player.rotation
		add_child(bullet)
	if last_screen_size != screen_size:
		replace(digits, screen_size)
	last_screen_size = screen_size
	last_score = score
	#digit.position = Vector2(screen_size.x-SCORE_EDGE_OFFSET, SCORE_EDGE_OFFSET)
	
	
