extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	const POWER_ROOM = preload("res://Scenes/Second floor rooms/power_room.tscn")
	if PositionManager.HasCrowbar:
		PositionManager.HasOpenedVent = true
		get_node("Sprite2D").hide()
		StageManager.changeScene(POWER_ROOM, 184, 120)
		StageManager.changeCamera(304)
		StageManager.scene_change = true


