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

func give_ammo_back():
	if get_parent() != null and get_parent().get_child(1) != null:
		get_parent().get_child(1).bullet_count += 1

func _process(delta):
	if exit_status == "click":
		give_ammo_back()
		queue_free()
	if exit_status == "X":
		print("x")
		give_ammo_back()
		queue_free()
