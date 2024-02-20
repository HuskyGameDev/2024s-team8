extends CanvasLayer


var player_position

func _ready():
	get_node("ColorRect").hide()

func changeScene(stage_next, x, y):
	var stage = stage_next.instantiate()
	
	player_position = stage.get_node("Player").position
	player_position = Vector2(x, y)
	
	get_node("ColorRect").show()
	get_node("AnimationPlayer").play("Fade_In")
	await get_node("AnimationPlayer").animation_finished
	
	get_tree().change_scene_to_packed(stage_next)
	
	#print(stage.get_node("Player").position)
	get_node("AnimationPlayer").play("Fade_Out")
	await get_node("AnimationPlayer").animation_finished
	get_node("ColorRect").hide()
