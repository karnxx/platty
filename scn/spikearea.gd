extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'plr':
		body.get_dmged(1)
