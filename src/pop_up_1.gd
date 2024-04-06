extends Node2D

var Click = preload("res://src/click.tscn")
var X =preload("res://src/x_node.tscn")
var exit_status = "no exit status"


func _ready():
	var click = Click.instantiate()
	click.position = Vector2(80, 290)
	add_child(click)
	
	var x = X.instantiate()
	x.position = Vector2(285, 15)
	add_child(x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if exit_status == "click":
		print('sadasd')
		queue_free()
	if exit_status == "X":
		print("x")
		queue_free()
	#print(exit_status)
