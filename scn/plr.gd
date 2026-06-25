extends CharacterBody2D

var grav = 600.0
var spd = 300.0
var maxspd = 600.0
var accel = 1500.0
var friction = 2200.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += grav * delta
	var dir = 0.0
	if Input.is_action_pressed("ui_left"):
		dir = -1.0
	elif Input.is_action_pressed("ui_right"):
		dir = 1.0
	
	if dir != 0.0:
		velocity.x += dir * accel * delta
		velocity.x = clamp(velocity.x, -maxspd, maxspd)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)
	
	move_and_slide()

func animate():
	if velocity.x != 0:
		$anim.play("run")
