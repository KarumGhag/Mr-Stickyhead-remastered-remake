extends Node2D
class_name Spike

@export var returnToStart : bool = false
var flag : Flag
var nextLevel : int
var currentScene
var currentSceneInt : int

func _ready():
	currentScene = get_tree().current_scene.scene_file_path
	flag = get_tree().get_first_node_in_group("Flag")

func _on_area_2d_body_entered(body):
	if body is Player:
		if returnToStart:
			get_tree().change_scene_to_file("res://scences/levels/level_12.tscn")
			currentSceneInt = int(currentScene) - 1
			nextLevel = currentSceneInt + 1
			flag.resetNextLvl(nextLevel)
			
			return
		body.kill()
