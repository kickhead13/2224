extends Node2D

var main_theme_audio = preload("res://resources/sounds/main_theme.wav")
var ButtonQ = preload("res://src/question_button.tscn")

var main_theme = null
var index = 0

const questions = [
	["for i in [1,2,3]: print(i)","123","51015","234"],
	["511+5=","60","55","100"],
	["spceship","a","s","m"],
	["sta","r","w","aa"],
	["10-10+10-10","0","10","100"],
	["for a in range(0,2): print(a)","0 1","0 1 2 3","10 11"],
	["recyc_e","l","e","y"],
	["_alaxy","g","w","h"],
	["112=","2","4","112"],
	["1<<1","2","11","1"],
	["wxy_","z","a","0"],
	["10*2","20","100","12"]
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	main_theme = AudioStreamPlayer.new()
	main_theme.stream = main_theme_audio
	main_theme.autoplay = true
	add_child(main_theme)
	index = randi_range(0, questions.size()-1)
	
	var correct_answer = questions[index][1]
	questions[index].shuffle()
	var iter = 0
	for answer in questions[index]:
		if iter != 0:
			var but1 = ButtonQ.instantiate()
			but1.position = Vector2(-40, 100 + 40 * (iter-1))
			but1.get_child(1).text = answer
			if answer == correct_answer:
				but1.get_child(0).type = "CORRECT"
			add_child(but1)
		iter += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label2.text = questions[index][0]
