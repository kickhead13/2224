extends Node2D

var Player = preload("res://src/character_body_2d.tscn")
var BasicBullet = preload("res://src/bullet.tscn")
var Bullet_Display = preload("res://src/bullet_display.tscn")
var Rec_Bottle = preload("res://src/rec_bottle.tscn")
var Waste_Bottle = preload("res://src/waste_bottle.tscn")
var Digit = preload("res://src/digit.tscn")
var PopUp = preload("res://src/pop_up_1.tscn")
var Hearts_Display = preload("res://src/hearts_display.tscn")
var main_theme_audio = preload("res://resources/sounds/main_theme.wav")
var shoot_effect_audio = preload("res://resources/sounds/Shoot.mp3")
var question_effect_audio = preload("res://resources/sounds/Emergency Sound.wav")


var Terminal = preload("res://src/terminal.tscn")
var mob_spawn_rate = 400
var mob_drop_off = 30
var popup_spawn_rate = 2000
var popup_drop_off = 100

var Bullet = BasicBullet
var player = Player.instantiate()
var bullet_displays = []
var heart_displays = []
var score = 0
var digits = []
var screen_size = 0
var last_screen_size = Vector2.ZERO
var last_score = 234
var spawner_pos= []
var rec_bottles_contor = 0
var number_of_mobs = 20
var rand_scale = [0.6 , 0.7 , 0.8 , 0.9 , 1 , 1.2 , 1.4 , 1.5 , 1.6 , 1.7, 1.8]
var rand_health = [4 , 6 , 8 , 10 , 12 , 14 , 16 , 18 , 20 , 22, 24]
var label = null
var main_theme = null
var shoot_effect = null
var question_effect = null

const BULLET_ROW = 10
const BULLET_COLUMN = 20
const BULLET_COLUMN_OFFSET = 20
const SCORE_EDGE_OFFSET = 18
const NUM_OF_DIGITS = 6
const CHARACTER_EDGE_OFFSET = 60
const MAX_REC_BOTTLES = 2

const HEARTS_ROW = 35
const HEARTS_COLUMN = 15
const HEARTS_COLUMN_OFFSET = 15

const POPUP_LOWER_LIMIT = -20
const POPUP_UPPER_LIMIT = 290


func spawn_mobs():
	print("????")
	var x=0
	var y=0
	var x_negative=0
	var y_negative=0
	var choose_x
	var choose_y
	var choose_mob = randi() % 4 + 1
	var screen_size = get_viewport_rect().size
	if(choose_mob == 1 && rec_bottles_contor < MAX_REC_BOTTLES):
		rec_bottles_contor += 1
		var rec_bottle = Rec_Bottle.instantiate()
		x = randi_range(screen_size.x, screen_size.x + 20)
		y = randi_range(screen_size.y, screen_size.y + 20)
		x_negative = randi_range(0, -20)
		y_negative = randi_range(0, -20)
		choose_x = randi() % 2 + 1
		if choose_x == 1:
			rec_bottle.position.x = x
		else:
			rec_bottle.position.x = x_negative
		
		choose_y = randi() % 2 + 1
		if choose_y == 1:
			rec_bottle.position.y = y
		else:
			rec_bottle.position.y = y_negative
		add_child(rec_bottle)
	else:
		var waste_bottle = Waste_Bottle.instantiate()
		x = randi_range(screen_size.x, screen_size.x + 20)
		y = randi_range(screen_size.y, screen_size.y + 20)
		x_negative = randi_range(0, -20)
		y_negative = randi_range(0, -20)
		choose_x = randi() % 2 + 1
		if choose_x == 1:
			waste_bottle.position.x = x
		else:
			waste_bottle.position.x = x_negative

		choose_y = randi() % 2 + 1
		if choose_y == 1:
			waste_bottle.position.y = y
		else:
			waste_bottle.position.y = y_negative
		var index = randi_range(0,rand_scale.size() - 1)
		waste_bottle.health = rand_health[index]
		waste_bottle.NORMAL_SCALE = rand_scale[index]
		waste_bottle.score = rand_health[index]
		waste_bottle.damage = rand_health[index]/3
		add_child(waste_bottle)


func spawn_popup(x,y):
	var popup = PopUp.instantiate()
	popup.position = Vector2(screen_size.x / 2 - x, screen_size.y / 2 - y)
	add_child(popup)

func _ready():
	Engine.max_fps=60
	screen_size = get_viewport_rect().size
	player.position = Vector2(300,500)
	add_child(player)
	label = Label.new() 
	add_child(label)
	main_theme = AudioStreamPlayer.new()
	main_theme.stream = main_theme_audio
	main_theme.autoplay = true
	add_child(main_theme)
	
	for i in range(player.MAX_INITIAL_BULLETS / 2):
		var bullet_display=Bullet_Display.instantiate()
		add_child(bullet_display)
		bullet_display.position.y = BULLET_ROW
		bullet_display.position.x = BULLET_COLUMN + BULLET_COLUMN_OFFSET * i
		bullet_displays.push_back(bullet_display)
		
	for i in range(player.MAX_INITIAL_HEARTS):
		var heart_display = Hearts_Display.instantiate()
		add_child(heart_display)
		heart_display.position.y = HEARTS_ROW
		heart_display.position.x = HEARTS_COLUMN + HEARTS_COLUMN_OFFSET * i
		heart_displays.push_back(heart_display)
	
	for iter in range(NUM_OF_DIGITS):
		var digit = Digit.instantiate()
		digit.position = Vector2(screen_size.x-SCORE_EDGE_OFFSET * (iter + 1), SCORE_EDGE_OFFSET)
		digits.push_back(digit)
		add_child(digit)

func refresh_bullet_display():
	for bullet_display in bullet_displays:
		if bullet_display != null:
			bullet_display.queue_free()
	for i in range(0, player.bullet_count):
		var bullet_display=Bullet_Display.instantiate()
		add_child(bullet_display)
		bullet_display.position.y = BULLET_ROW
		bullet_display.position.x = BULLET_COLUMN + BULLET_COLUMN_OFFSET * i
		bullet_displays.push_back(bullet_display)


func refresh_hearts_display():
	for heart_display in heart_displays:
		if heart_display != null:
			heart_display.queue_free()
	for i in range((player.hearts_count+1)):
		var heart_display = Hearts_Display.instantiate()
		add_child(heart_display)
		heart_display.position.y = HEARTS_ROW
		heart_display.position.x = HEARTS_COLUMN + HEARTS_COLUMN_OFFSET * i
		heart_displays.push_back(heart_display)


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
	
	if score % 200 == 0:
		mob_spawn_rate -= mob_drop_off
		popup_spawn_rate -= popup_drop_off
		if mob_drop_off > 0:
			mob_drop_off -= 2
		if popup_drop_off > 0:
			popup_drop_off -= 10
	
	screen_size = get_viewport_rect().size
	if label != null:
		label.position = Vector2(screen_size.x/2, 0)
	if randi_range(0,mob_spawn_rate) == 0:
		spawn_mobs()
	if randi_range(0, popup_spawn_rate) == 0:
		spawn_popup(randi_range(POPUP_LOWER_LIMIT, POPUP_UPPER_LIMIT), randi_range(POPUP_LOWER_LIMIT, POPUP_UPPER_LIMIT))
	if last_score != score:
		update_score_digits(digits)
	refresh_bullet_display()
	if Input.is_action_just_pressed("shoot") && player.bullet_count > 0:
		shoot_effect = AudioStreamPlayer.new()
		shoot_effect.stream = shoot_effect_audio
		shoot_effect.autoplay = true
		shoot_effect.volume_db = -15
		add_child(shoot_effect)
		player.bullet_count -= 1
		player.heat += 1
		var bullet = Bullet.instantiate()
		bullet.position = player.position
		bullet.rotation = player.rotation
		bullet.damage = player.bdamage
		add_child(bullet)
		if player.heat == player.OVERHEAT:
			question_effect = AudioStreamPlayer.new()
			question_effect.stream = question_effect_audio
			question_effect.autoplay = true
			add_child(question_effect)
			var terminal = Terminal.instantiate()
			terminal.position = Vector2(screen_size.x-300, screen_size.y-400)
			add_child(terminal)

	if last_screen_size != screen_size:
		replace(digits, screen_size)
	last_screen_size = screen_size
	last_score = score
	
	refresh_hearts_display()
	if player.hearts_count > 0:
		player.hearts_count = player.health
		
