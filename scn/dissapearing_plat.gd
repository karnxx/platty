extends StaticBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'plr':
		var twen = create_tween()
		twen.tween_property(self, "modulate:a", 0.0, 0.5)
		await twen.finished
		visible = false
		if !visible:
			var twen2 = create_tween()
			twen2.tween_property(self, "modulate:a", 1.0, 2)
			visible = true
