extends CharacterBody2D


var plr

func _physics_process(delta: float) -> void:
	var dir 
	if plr:
		dir = (plr.global_position - global_position).normalized() * 100
	if dir:
		velocity = dir * 1
		if dir.x > 0:
			$AnimatedSprite2D.flip_h = true
		elif dir.x < 0:
			$AnimatedSprite2D.flip_h = false
	move_and_slide()

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		plr = body


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		body.coins -= 2


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		body.coins += 10
		body.boost("u")
		queue_free()
