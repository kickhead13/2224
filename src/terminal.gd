extends Node2D

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
	index = randi_range(0, questions.size()-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label2.text = questions[index][0]
