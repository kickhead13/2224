extends Node2D

var Info_Button = preload("res://src/info_button.tscn")
var Start_Button = preload("res://src/start_button.tscn")
var main_theme_audio = preload("res://resources/sounds/main_theme.wav")

var main_theme = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var info = Info_Button.instantiate()
	info.position = Vector2(0, 80)
	add_child(info)
	
	var start = Start_Button.instantiate()
	start.position = Vector2(0, 120)
	add_child(start)
	
	main_theme = AudioStreamPlayer.new()
	main_theme.stream = main_theme_audio
	main_theme.autoplay = true
	add_child(main_theme)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
