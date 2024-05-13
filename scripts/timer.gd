extends Node2D

var totalTime : float
var currentTime : float
var gameStarted : bool = false

var splits : Array = []

@export var totalTimeLabel : Label
@export var currentTimeLabel : Label
@export var splitsTimeLabel : Label
@export var currentLevel : Label

var timePassed : String = ""
var currentPassed : String = ""

var savedTime : float
var splitsTxt : String

var subLevel : int = 0

var endPoint : Node2D
var endPointPos : Vector2

func _ready():
	currentLevel.hide()
	totalTimeLabel.hide()
	currentTimeLabel.hide()
	splitsTimeLabel.hide()
	

func startTimer():
	gameStarted = true
	currentLevel.show()
	totalTimeLabel.show()
	currentTimeLabel.show()
	splitsTimeLabel.show()


func _process(delta):
	if gameStarted:
		totalTime += delta
		totalTime = (snapped(totalTime, 0.001))

	var mils = fmod(totalTime,1)*1000
	var seconds = floori(fmod(totalTime,60))
	var minutes = floori(fmod(totalTime,60 * 60) / 60)
	
	var levelMils = fmod((totalTime -  savedTime),1)*1000
	var levelSeconds = floori(fmod((totalTime - savedTime),60))
	var levelMinutes = floori(fmod((totalTime - savedTime),60 * 60) / 60)
	
	timePassed = "%02d:%02d:%d" % [ minutes, seconds, mils ]
	currentPassed = "%02d:%02d:%d" % [ levelMinutes, levelSeconds, levelMils ]
	
	totalTimeLabel.text = "Total Time: " + str(timePassed)
	currentTimeLabel.text = "Level Time: " + str(currentPassed)
	splitsTimeLabel.text = "Splits: " + splitsTxt
	
		
	
func saveTime():
	savedTime = totalTime
	splits.append(currentPassed)
	splitsTxt += "|" + str(currentPassed) + "|"

func updateLevel(current : String, newLevel : bool, subLevel : String):
	var currentInt = int(current)
	if currentInt < 12:
		currentLevel.text = "Level: " + str(current)
		return
	else:
		if subLevel == "" or subLevel == "0":
			currentLevel.text = "Level: 12"
			
			return
		currentLevel.text = "Level: 12 - " + str(subLevel) 
		
			
	
func addSub():
	subLevel += 1
	return subLevel

func updateEndPoint():
	endPoint = get_tree().get_first_node_in_group("EndPoint")
	if endPoint == null:
		return Vector2.ZERO
	endPointPos = endPoint.position
	return endPointPos

func playerToEnd(pos):
	var player = get_tree().get_first_node_in_group("Player")
	player.position = endPointPos
	return
