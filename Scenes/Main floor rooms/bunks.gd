extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	const HALLWAY_MAIN = preload("res://Scenes/Main floor rooms/hallway_main.tscn")
	if body.name == "Player":
		StageManager.changeScene(HALLWAY_MAIN, 184, 120)
		StageManager.changeCamera(488)
