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

func _ready():
	screen_size = get_viewport_rect().size
	
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
	# print(score)
	
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
	
