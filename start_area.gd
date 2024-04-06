extends Area2D


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
	var game = preload("res://src/node_2d.tscn").instantiate()
	if event.button_mask == 1:# and type_string(typeof(event)) == "InputEventMouseButton":
		get_tree().root.add_child(game)
		if get_parent() != null and get_parent().get_parent() != null:
			get_parent().get_parent().queue_free()
