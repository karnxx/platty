extends CharacterBody2D
var grav = 600.0
var spd = 300.0
var maxspd = 600.0
var accel = 1500.0
var friction = 2200.0
var is_jumping = false:
	set(value):
		is_jumping = value
		jumpchanged(value)
var jumpanim = false
var lastfloor = false
var jhold = 0.0

func _process(delta: float) -> void:
	reflect()
	animate()

func reflect():
	$anim2.flip_h = $anim.flip_h
	$anim2.frame = $anim.frame
	if $RayCast2D.is_colliding() and $RayCast2D.get_collider().name == 'flr':
		$anim2.visible = true
		var point = $RayCast2D.get_collision_point()
		var dist = $anim.global_position.distance_to(point)
		$anim2.position = Vector2($anim.position.x, $anim.position.y + (dist * 2))
	else:
		$anim2.visible = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += grav * delta
	var dir = 0.0
	if Input.is_action_pressed("ui_left"):
		dir = -1.0
	elif Input.is_action_pressed("ui_right"):
		dir = 1.0
	if is_on_floor():
		if is_jumping:
			is_jumping = false
		lastfloor = true
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_jumping = true
		velocity.y = -400
		jhold = 0.3
	if Input.is_action_pressed("ui_accept") and jhold > 0:
		velocity.y -= 900 * jhold * get_physics_process_delta_time()
		jhold -= get_physics_process_delta_time()
	if Input.is_action_just_released("ui_accept"):
		jhold = 0.0
		if velocity.y < 0:
			velocity.y *= 0.5
	if dir != 0.0:
		velocity.x += dir * accel * get_physics_process_delta_time()
		velocity.x = clamp(velocity.x, -maxspd, maxspd)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * get_physics_process_delta_time())
	move_and_slide()

func jumpchanged(val):
	if val == false:
		return
	jumpanim = true
	$anim.play("jump")
	$anim2.animation = $anim.animation
	await $anim.animation_finished
	jumpanim = false

func animate():
	if velocity.x < 0:
		$anim.flip_h = true
	elif velocity.x > 0: 
		$anim.flip_h = false
	var dira = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")
	if !is_on_floor() and velocity.y > 0 and !jumpanim:
		$anim.play("fall")
		$anim2.animation = $anim.animation
	elif velocity.x != 0 and !jumpanim and is_on_floor():
		$anim.play("run")
		$anim2.animation = $anim.animation
	elif velocity.x == 0 and !jumpanim and is_on_floor() and dira == false:
		$anim.play("idle")
		$anim2.animation = $anim.animation
