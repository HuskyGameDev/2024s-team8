extends Node2D

@export var facing = true
signal touched()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		touched.emit()
		body.hasAttention = false
		body.find_child("AnimationTree").set("active", false)
		var scare = get_node("CanvasLayer/Node2D")
		scare.deathTime()
		await scare.scareDone
		get_tree().change_scene_to_file("res://Scenes/Transition Scenes/deathScreen.tscn")
		StageManager.scene_change = true

func _process(_delta: float) -> void:
	get_node("Sprite2D").flip_h = facing
