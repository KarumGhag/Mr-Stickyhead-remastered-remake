extends Node2D
class_name Flag

@export var animator : AnimatedSprite2D

var levelName : String = "res://scences/levels/level_"

@onready var globalTimer : Node = get_node("/root/GlobalTimer")
@export var split : bool = true

@export var forward : bool = true

var nextLevel : int
@onready var gameState = get_node("/root/GlobalTimer")

@export var player : CharacterBody2D
var spawnPoint : Node2D
var endPoint : Node2D
var endPointPos : Vector2 = Vector2.ZERO

var subLevel : int = 0
var currentScene

func _ready():
	animator.play("Flying")
	player = get_tree().get_first_node_in_group("Player")
	endPoint = get_tree().get_first_node_in_group("EndPoint")
	spawnPoint = get_tree().get_first_node_in_group("SpawnPoint")
	
	
func _on_area_2d_body_entered(body):
	if body is Player:
		if split:
			globalTimer.saveTime()
		else:
			subLevel = gameState.addSub()
			gameState.updateLevel("12", false, str(subLevel))
		call_deferred("change_level")

func change_level():
	currentScene = get_tree().current_scene.scene_file_path
	if forward:
		nextLevel = currentScene.to_int() + 1
	else:
		nextLevel = currentScene.to_int() - 1
		
	var nextLevelPath = levelName + str(nextLevel) + ".tscn"
	gameState.updateEndPoint()
	
	print(get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file(nextLevelPath)
	
	
	

	
	
	if split:
		gameState.updateLevel(str(nextLevel), true, "")
	else:
		gameState.updateLevel("12", false, str(subLevel))

func resetNextLvl(correctNextLvl):
	subLevel = 0
	gameState.updateLevel("12", false, str(subLevel))
