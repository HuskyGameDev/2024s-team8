extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_to_first_floor_body_entered(body):
	if body.name == "Player":
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		const HALLWAY_MAIN = preload("res://Scenes/Main floor rooms/hallway_main.tscn")
		StageManager.changeScene(HALLWAY_MAIN, 442, 131)
		StageManager.changeCamera(488)
		StageManager.scene_change = true
		StageManager.on_first_floor == true


func _on_to_second_floor_body_entered(body):
	if body.name == "Player":
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		const HALL = preload("res://Scenes/Second floor rooms/hallway_top.tscn")
		StageManager.changeScene(HALL, 213, 121)
		StageManager.changeCamera(488)
		StageManager.scene_change = true
		StageManager.on_first_floor == false
