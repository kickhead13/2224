extends RigidBody2D

const TYPE = "waste"

func _on_body_entered(body):
	print("test")


func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		queue_free()
