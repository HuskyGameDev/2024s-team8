extends Node2D


@onready var note = get_tree().get_first_node_in_group("Note")

var count = 0

func _ready():
	if PositionManager.HasNote:
		note.queue_free()


func _on_to_bottom_hallway_body_entered(_body):
	count += 1
	if count > 1:
		const HALLWAY_BOT = preload("res://Scenes/Second floor rooms/hallway_bottom.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_BOT, 388, 122)
		StageManager.changeCamera(480)
		StageManager.scene_change = true
