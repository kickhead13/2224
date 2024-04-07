extends Area2D

var type = "INCORRECT"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	if get_parent() != null:
		$Sprite2D.texture = load("res://resources/button_back_hov.png")


func _on_mouse_exited():
	if get_parent() != null:
		$Sprite2D.texture = load("res://resources/button_back.png")


func _on_input_event(viewport, event, shape_idx):
	if event.button_mask == 1:# and type_string(typeof(event)) == "InputEventMouseButton":
		if get_parent() != null and get_parent().get_parent() != null and get_parent().get_parent().get_parent() != null and type == "CORRECT" and get_parent().get_parent().get_child(1) != null:
			get_parent().get_parent().queue_free()
			# print(get_parent().get_parent())
			get_parent().get_parent().get_parent().get_child(1).heat = 0
