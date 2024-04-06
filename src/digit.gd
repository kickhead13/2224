extends RigidBody2D

const INFLATE_OFFSET = 5
const NORMAL_SCALE = 1 
const INFLATE_SCALE = 1.4

var inflate_timer = 0

func set_val(val):
	if val >= 0 and val < 10:
		$Sprite2D.texture = load("res://resources/digits/digit" + str(val) + ".png")
		scale = Vector2(INFLATE_SCALE, INFLATE_SCALE)
		inflate_timer = INFLATE_OFFSET

func _process(delta):
	if inflate_timer > 0:
		inflate_timer -= 1
	if inflate_timer == 0 and scale != Vector2(NORMAL_SCALE, NORMAL_SCALE):
		scale = Vector2(NORMAL_SCALE, NORMAL_SCALE)
