extends RigidBody2D

const TYPE = "rec"
@onready var health = 10 

func hit(damage):
	health -= damage
	if health < 0:
		health = 0
	if health == 0:
		queue_free()
