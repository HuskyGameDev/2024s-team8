extends Node

var Position = Vector2.ZERO
var PrevPosition = Vector2.ZERO
var HasCrowbar = false
var HasOpenedVent = false
var StartFromBeginning = false
var hasClearedPipe = false
var HasClearedValve = false
var hasClearedCombo = false
var Act = 0
var comboCode := [0,0,0,0,1]
var valveCode := [9,6,3]
var HasOpenedTutorial = false
var OpenedAirlock = false
var HasEatenBurger = false
var SecurityEnabled = true
var hasCode = false
var HasNote = false
var HasReadEscapeText = false
var textSpd = 1.0 # Factor for text speed
	
	
	
