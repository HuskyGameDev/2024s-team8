extends Node2D



func _on_body_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hasAttention = false
		var scare = get_node("CanvasLayer/Node2D")
		scare.visible = true
		scare.deathTime()
		await scare.scareDone
		get_tree().change_scene_to_file("res://Scenes/Transition Scenes/deathScreen.tscn")
		StageManager.scene_change = true
