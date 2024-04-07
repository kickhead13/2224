extends Node2D

var Click = preload("res://src/click.tscn")
var X = preload("res://src/x_node.tscn")
var exit_status = "no exit status"
var popup_sound = preload("res://resources/sounds/Popup.wav")
var pop_sound = null

func _ready():
	var click = Click.instantiate()
	click.position = Vector2(80, 290)
	add_child(click)
	var x = X.instantiate()
	x.position = Vector2(265, 10)
	add_child(x)
	
	pop_sound = AudioStreamPlayer.new()
	pop_sound.stream = popup_sound
	pop_sound.autoplay=true
	add_child(pop_sound)

func give_ammo_back():
	if get_parent() != null and get_parent().get_child(1) != null and get_parent().get_child(1).bullet_count > 0:
		get_parent().get_child(1).bullet_count += 1

func _process(delta):
	if exit_status == "click":
		give_ammo_back()
		if get_parent() != null and get_parent().get_child(1) != null:
			get_parent().get_child(1).mode = get_parent().get_child(1).MALWARE[randi_range(0, get_parent().get_child(1).MALWARE.size()-1)]
			if get_parent().get_child(1).mode == "more_max_bullet":
				get_parent().get_child(1).param1 = randi_range(0,5)
			elif get_parent().get_child(1).mode == "lower_speed":
				get_parent().get_child(1).param1 = randi_range(2, 4)
		queue_free()
	if exit_status == "X":
		give_ammo_back()
		queue_free()
