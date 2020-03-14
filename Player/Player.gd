extends KinematicBody2D

var motion = Vector2(0,0)

const SPEED = 850
const GRAVATY = 270
const UP = Vector2(0, -1)
const JUMP_SPEED = 4200
const WORLD_LIMIT = 4000

signal enimate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)
	
func apply_gravity():
	if position.y > WORLD_LIMIT:
		end_game()
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVATY

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED
	
func animate():
	emit_signal("enimate", motion)
	
func end_game():
	get_tree().change_scene("res://levels/GameOver.tscn")
