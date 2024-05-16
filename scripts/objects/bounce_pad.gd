extends Node2D
class_name BouncePad

@export var bounceBuffer : float
@export var sideBuffer : float
@export var isLeft : bool = false
@export var isRight : bool = false

func _on_area_2d_body_entered(body):
	if body is Player:
		if isLeft or isRight:
			body.sideBounce(isLeft, isRight, sideBuffer, bounceBuffer)
			return
		body.bounce(bounceBuffer)
		
