extends CharacterBody2D

const TYPE = "waste"
var health = 10
var damage = 1
const INFLATE_OFFSET = 5
const SCALE_OFFSET = 1.2
const NORMAL_SCALE = 1
var inflate_timer = INFLATE_OFFSET
const friction = 300
const BOUNCE_SPEED = 200
var score = 1

func _on_body_entered(body):
	print("test")

func _physics_process(delta):
	if inflate_timer > 0:
		inflate_timer -= 1
	if inflate_timer == 0 and scale != Vector2(NORMAL_SCALE,NORMAL_SCALE):
		scale = Vector2(1, 1)
	bottle_movement(delta)

func bottle_movement(delta):
	if velocity.length() > (friction * delta):
		velocity -= velocity.normalized() * (friction * delta)
	else:
		velocity = Vector2.ZERO
	#partea care da speed la caracte
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		hit(area.get_parent().damage)
		var dirx = area.get_parent().transform.x #	 [x = ... , y = ...]
		velocity = Vector2(dirx.x*BOUNCE_SPEED,dirx.y*BOUNCE_SPEED)
		area.get_parent().queue_free()
		scale = Vector2(SCALE_OFFSET, SCALE_OFFSET)
		inflate_timer = INFLATE_OFFSET
		# print(velocity)
	

func hit(damage):
	health -= damage
	if health < 0:
		health = 0
	if health == 0:
		get_parent().score += score
		queue_free()
