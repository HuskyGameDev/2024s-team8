extends CanvasLayer


var player_position = Vector2.ZERO
var right_camera_limit = 1000000000000000
var scene_change = false
var on_first_floor = true
var player_facing = Vector2(0, 1)
signal Scene_change

func _ready():
	get_node("ColorRect").hide()

#when stagemanager is called switches players hasAttention to the opposite of scene change
#fades out and in to the scene after changing scenes as well as changing player position
func changeScene(stage_next, x, y, door = false):
	var _stage = stage_next.instantiate()
	
	player_position = Vector2(x, y)
	
	# If the scene change is due to a door, play the door sound effect
	if(door == true):
		GlobalAudioManager.door_SFX()
	
	get_node("AnimationPlayer").play("Fade_In")
	await get_node("AnimationPlayer").animation_finished
	
	scene_change = true
	get_tree().change_scene_to_packed(stage_next)
	
	get_node("AnimationPlayer").play("Fade_Out")
	await get_node("AnimationPlayer").animation_finished
	Scene_change.emit()
	scene_change = false
	
	
#changes the right camera limit
func changeCamera(limit):
	right_camera_limit = limit
	
