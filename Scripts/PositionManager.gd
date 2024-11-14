extends Node

@onready var notificationScene = preload("res://Scripts/Notifications/Notification.tscn")

var Canvas = null

var Position = Vector2.ZERO
var PrevPosition = Vector2.ZERO
var HelianthRelativePosition = Vector2(88-400, 144-144)

#Default Minigames
var comboCode := [0,0,0,0,1]
var valveCode := [9,6,3]
var PipeVersion = 0

#Game Progression
var Act = 0
var HasOpenedTutorial = false
var OpenedAirlock = false
var ViewedWallMap = false
var ConfigLoaded = false
var SecurityEnabled = true
var hasCode = false
var HasNote = false
var HasReadEscapeText = false
var HasReadEscapeText2 = false
var HasPoem = false
var HasCrowbar = false
var HasOrb = false
var HasSpaceSuit = false
var HasHeatLamp = false
var HasMeat = false
var hasDecoy = false
var performingDecoy = false
var HasOpenedVent = false
var StartFromBeginning = false
var hasClearedPipe = false
var HasClearedValve = false
var hasClearedDial = false
var hasActivatedHeli = false
var hasEscapedGreenhouse = false
var heliDistracted = false
var HasDefeatedMonster = false

#Default Settings
var masterVolume = 0.5
var musicVolume = 0.5
var sfxVolume = 0.5
var dialogueVolume = 0.5
var textSpd = 1.0 # Factor for text speed
var crt_effect = 0
var playTextSound = true
var finished_displaying = true

#ObjectivesMenu Information 
var Objectives = []
var ObjectivesText = []
var Documents = []
var DocumentsText = []
var Inventory = []
var InventoryText = []
var InventorySprite = []


var redLight = "3f0000"
var pinkLight = "cba3ff"
var purpleLight = "0f0073"
var RetainPlayerSpeed = false
var pinkLamp = "f187ff8c"
var paused = false
@onready var dest = 0
@onready var destOrder = [1, 0, 1, 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 10, 11, 9, 8, 7, 6, 5, 4, 3, 2, 0]

var lastKnownPos = Vector2.ZERO


func _process(_delta):
	Canvas = GlobalCanvasLayer.get_child(0)


#turns arrays that contain text to strings
func array_to_string(arr: Array, skipLines: int = 0) -> String:
	var string = ""
	for i in range(skipLines, arr.size()):
		string += str(arr[i])
		string += " "
	return string


func add_objective(objective: String, text : String):
	Objectives.append(objective)
	ObjectivesText.append(text)
	play_notification("Objective")

func remove_objective(objective: String):
	var i = 0
	while (i < Objectives.size()):
		if Objectives[i] == objective:
			Objectives.remove_at(i)
			ObjectivesText.remove_at(i)
			return
		i += 1

func play_notification(type: String):
	var notification1 = notificationScene.instantiate()
	if type == "Objective":
		notification1.get_child(0).get_child(0).text = "Objectives Updated"
	elif type == "Document":
		notification1.get_child(0).get_child(0).text = "New Document Added"
	if Canvas != null:
		if Canvas.get_child_count() > 0:
			Canvas.get_child(0).queue_free()
		Canvas.add_child(notification1)


func getDirection(rotation : float):
	if rotation == 0:
		return Vector2(-1, 0)
	elif rotation == 90:
		return Vector2(0, -1)
	elif rotation == 180:
		return Vector2(1, 0)
	elif rotation == 270:
		return  Vector2(0, 1)
