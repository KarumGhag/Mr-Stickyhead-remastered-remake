extends Node2D
class_name Spike

@export var returnToStart : bool = false

func _on_area_2d_body_entered(body):
	if body is Player:
		if returnToStart:
			get_tree().change_scene_to_file("res://scences/levels/level_12.tscn")
			return
		body.kill()
