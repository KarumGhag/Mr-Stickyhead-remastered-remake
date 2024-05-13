extends Node2D
class_name Spike

@export var returnToStart : bool = false
var flag : Flag
var nextLevel : int
var currentScene
var currentSceneInt : int

@onready var gameState = get_node("/root/GlobalTimer")
var endPointPos : Vector2 


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
			gameState.subLevel = 0
			flag.subLevel = 0
			flag.endPointPos.x = 60
			flag.endPointPos.x = 326
			
			
			return
		body.kill()
