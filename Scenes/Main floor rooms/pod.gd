extends Node2D
var HasLeft = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_to_hall_body_entered(body):
	if HasLeft:
		const HALLWAY = preload("res://Scenes/Main floor rooms/hallway_main.tscn")
		StageManager.changeScene(HALLWAY, 75, 128)
		StageManager.changeCamera(488)
		StageManager.scene_change = true



func _on_to_hall_body_exited(body):
	HasLeft = true
