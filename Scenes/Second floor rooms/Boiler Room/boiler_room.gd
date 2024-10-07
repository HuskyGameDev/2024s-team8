extends Node2D

@onready var Fog = get_tree().get_first_node_in_group("Fog")
@onready var note = get_tree().get_first_node_in_group("Note")

var count = 0

func _ready():
	if PositionManager.HasNote:
		note.queue_free()
	if PositionManager.HasClearedValve:
		Fog.queue_free()


func _on_to_bottom_hallway_body_entered(_body):
	if Input.is_action_pressed("DOWN") && _body.name == "Player":
		var HALLWAY_TOP = load("res://Scenes/Second floor rooms/Top Hallway/hallway_top.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(0,1)
		StageManager.changeScene(HALLWAY_TOP, 401, 115)
		StageManager.changeCamera(480)



func _on_valve_clear_fog() -> void:
	Fog.queue_free()
