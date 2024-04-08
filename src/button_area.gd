extends Area2D

var GAME_INFO = """DEAR PRISONER X""" + str(randi_range(134231, 994532)) + """

A couple hundred years ago (circa. 2024) a coalition of gouvernments ran a program to collect 
as much trash from earth and dump it into orbit. 

Due to the overwhelming ammount of garbage floating around in the outer orbit of earth, we can no
longer conduct our [secret activities] in a safe manner. We must take action immediatly to combat 
the spread of these objects.

You've been chosen to undergo the following mission: destroy as much WASTEFUL GARBAGE and collect
as much RECYCLABLE MATTERIAL as possible. You can get the job done by entering the SPACESHIP 
CONTROL INTERFACE. 

Be wary of malicious software that might appear during your mission. [Evil actors] don't take 
favorly of wour activities.

GOOD LUCK."""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	if get_parent() != null:
		$ButtonBack.texture = load("res://resources/button_back_hov.png")


func _on_mouse_exited():
	if get_parent() != null:
		$ButtonBack.texture = load("res://resources/button_back.png")


func _on_input_event(viewport, event, shape_idx):
	if event.button_mask == 1:# and type_string(typeof(event)) == "InputEventMouseButton":
		if get_parent() != null and get_parent().get_parent() != null:
			get_parent().get_parent().get_child(2).text = GAME_INFO
