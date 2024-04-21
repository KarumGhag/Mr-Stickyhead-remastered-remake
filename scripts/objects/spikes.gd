extends Node2D
class_name Spike

func _on_area_2d_body_entered(body):
	if body is Player:
		body.kill()
