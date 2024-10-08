extends Node

var Position = Vector2.ZERO
var PrevPosition = Vector2.ZERO
var HasCrowbar = false
var HasOrb = false
var HasSpaceSuit = false
var HasHeatLamp = false
var HasMeat = false
var hasDecoy = false
var HasOpenedVent = false
var StartFromBeginning = false
var hasClearedPipe = false
var HasClearedValve = false
var hasClearedDial = false
var HasDefeatedMonster = false
var Act = 0
var comboCode := [0,0,0,0,1]
var valveCode := [9,6,3]
var PipeVersion = 1
var HasOpenedTutorial = false
var OpenedAirlock = false
var ConfigLoaded = false
var SecurityEnabled = true
var hasCode = false
var HasNote = false
var HasReadEscapeText = false
var HasReadEscapeText2 = false
var textSpd = 1.0 # Factor for text speed
var playTextSound = true
var finished_displaying = true
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
var masterVolume = 0.5
var musicVolume = 0.5
var sfxVolume = 0.5
var dialogueVolume = 0.5
var heliDistracted = false
var lastKnownPos = Vector2.ZERO


#func _process(delta):
	#print(Act)

#turns arrays that contain text to strings
func array_to_string(arr: Array, skipLines: int = 0) -> String:
	var string = ""
	for i in range(skipLines, arr.size()):
		string += str(arr[i])
		string += " "
	return string
