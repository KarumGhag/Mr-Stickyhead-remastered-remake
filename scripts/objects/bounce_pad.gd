extends Node2D
class_name BouncePad

@export var bounceBuffer : float

func _on_area_2d_body_entered(body):
	if body is Player:
		body.bounce(bounceBuffer)
