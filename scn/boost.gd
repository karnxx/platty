extends Area2D

@export_enum('front', 'back') var type
@export var boost := 400


func _ready() -> void:
	$Sprite2D.frame = type

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'plr':
		body.maxspd += boost
		if type == 0:
			body.velocity.x += boost/2
		else:
			body.velocity.x -= boost/2
