extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		body.coins += 1
		$AnimatedSprite2D.play('pick')
		await $AnimatedSprite2D.animation_finished
		queue_free()
