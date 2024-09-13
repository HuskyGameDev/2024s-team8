extends CanvasLayer


var player_position = Vector2.ZERO
var right_camera_limit = 1000000000000000
var scene_change = false
var on_first_floor = true
func _ready():
	get_node("ColorRect").hide()

#when canvas layer is called changes scene_change to false if True
func _process(_delta):
	if scene_change == true:
		scene_change = false

#fades out and in to the scene after changing scenes as well as changing player position
func changeScene(stage_next, x, y, door = false):
	var _stage = stage_next.instantiate()
	
	player_position = Vector2(x, y)
	
	get_node("ColorRect").show()
	
	# If the scene change is due to a door, play the door sound effect
	if(door == true):
		GlobalAudioManager.door_SFX()
	
	get_node("AnimationPlayer").play("Fade_In")
	await get_node("AnimationPlayer").animation_finished
	
	get_tree().change_scene_to_packed(stage_next)
	
	get_node("AnimationPlayer").play("Fade_Out")
	await get_node("AnimationPlayer").animation_finished
	get_node("ColorRect").hide()
	
	
#changes the right camera limit
func changeCamera(limit):
	right_camera_limit = limit
	
