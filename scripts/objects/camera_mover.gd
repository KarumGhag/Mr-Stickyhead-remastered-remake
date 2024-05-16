extends Area2D

var player : Player
var camera : Camera2D

@export var isActive : bool = false
@export var myCentre : Node2D
@export var myNumber : int

@onready var gameState = get_node("/root/GlobalTimer")

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	camera = get_tree().get_first_node_in_group("Camera")

func _on_body_entered(body):
	if body is Player:
		isActive = true
		camera.position = myCentre.position
		gameState.changeCurrent(myNumber)

func _on_body_exited(body):
	if body is Player:
		isActive = false
		
		
