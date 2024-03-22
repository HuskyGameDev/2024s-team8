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
		body.hasAttention = false
		body.set("active", false)
		const AIRLOCK = preload("res://Scenes/Main floor rooms/airlock.tscn")
		StageManager.changeScene(AIRLOCK, 155, 110)
		StageManager.changeCamera(304)
		StageManager.scene_change = true



func _on_to_hall_body_exited(body):
	HasLeft = true
