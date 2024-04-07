extends Node2D

var main_theme_audio = preload("res://resources/sounds/main_theme.wav")
var main_theme = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	main_theme = AudioStreamPlayer.new()
	main_theme.stream = main_theme_audio
	main_theme.autoplay = true
	add_child(main_theme)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
