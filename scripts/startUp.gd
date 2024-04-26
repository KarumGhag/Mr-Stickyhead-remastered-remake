extends Node2D

@export var startUpBlack : Polygon2D
@export var startUpSprite : Sprite2D
@export var sound : AudioStreamPlayer2D
@export var skip : Label

@export var mainMenuNode : Node2D
@export var button : Button
@export var playerSprite : Sprite2D
@export var canvasLayer : CanvasLayer

func _ready():
	startUpBlack.show()
	startUpSprite.show()
	skip.hide()
	
	mainMenuNode.hide()
	button.hide()
	playerSprite.hide()
	canvasLayer.hide()

func _process(delta):
	if Input.is_action_just_pressed("skip"):
		makeMainMenu()#
		skip.hide()

func _on_audio_stream_player_2d_finished():
	makeMainMenu()

	
	
func makeMainMenu():
	startUpBlack.hide()
	startUpSprite.hide()
	skip.hide()
	sound.stop()
	
	mainMenuNode.show()
	button.show()
	playerSprite.show()
	canvasLayer.show()


func _on_show_exit_timeout():
	skip.show()


func _on_button_button_down():
	get_tree().change_scene_to_file("res://scences/levels/level_1.tscn")
