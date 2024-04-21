extends Node2D
class_name BouncePad

func _on_area_2d_body_entered(body):
	if body is Player:
		body.bounce()
