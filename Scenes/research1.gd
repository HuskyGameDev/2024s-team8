extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
var HasLeft = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if HasLeft:
		const HALLWAY_MAIN = preload("res://Scenes/hallway_main.tscn")
		StageManager.changeScene(HALLWAY_MAIN, 442, 131)
		StageManager.changeCamera(488)


func _on_door_to_hallway_body_exited(body):
	HasLeft = true
	pass # Replace with function body.
