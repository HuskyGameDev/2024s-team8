extends Node2D

var HasLeft = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	const HALLWAY_MAIN = preload("res://Scenes/Main floor rooms/hallway_main.tscn")
	if HasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_MAIN, 442, 131)
		StageManager.changeCamera(488)
		StageManager.scene_change = true


func _on_area_2d_body_exited(body):
	HasLeft = true
