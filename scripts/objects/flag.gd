extends Node2D
class_name Flag

@export var animator : AnimatedSprite2D
var levelName : String = "res://scences/levels/level_"

@onready var globalTimer : Node = get_node("/root/GlobalTimer")

func _ready():
	animator.play("Flying")

func _on_area_2d_body_entered(body):
	if body is Player:
		globalTimer.saveTime()
		var currentScene = get_tree().current_scene.scene_file_path
		var nextLevel = currentScene.to_int() + 1
		var nextLevelPath = levelName + str(nextLevel) + ".tscn"
		get_tree().change_scene_to_file(nextLevelPath)
