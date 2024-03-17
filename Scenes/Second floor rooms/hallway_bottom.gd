extends Node2D

@onready var Fog = get_tree().get_first_node_in_group("Fog")
var count = 0

func _ready():
	if PositionManager.HasClearedValve:
		Fog.queue_free()

func _on_to_the_transitionary_hallway_body_entered(_body):
	count += 1
	if count > 2:
		const HALLWAY_TRANS = preload("res://Scenes/Second floor rooms/hallway_transition.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_TRANS, 152, 146)
		StageManager.changeCamera(304)
		StageManager.scene_change = true


func _on_to_the_boiler_room_body_entered(_body):
	count += 1
	if count > 2:
		const BOILER_ROOM = preload("res://Scenes/Second floor rooms/boiler_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(BOILER_ROOM, 204, 146)
		StageManager.changeCamera(304)
		StageManager.scene_change = true
