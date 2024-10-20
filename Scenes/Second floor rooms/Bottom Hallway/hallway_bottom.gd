extends Node2D

@onready var Fog = get_tree().get_first_node_in_group("Fog")
var count = 0

func _ready():
	if PositionManager.HasClearedValve:
		Fog.queue_free()




func _on_to_the_boiler_room_body_entered(_body):
	count += 1
	if count > 2:
		var BOILER_ROOM = load("res://Scenes/Second floor rooms/Boiler Room/boiler_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(BOILER_ROOM, 204, 146)
		StageManager.changeCamera(304)
		StageManager.scene_change = true


func _on_valve_clear_fog():
	Fog.queue_free()
