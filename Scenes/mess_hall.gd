extends Node2D

@onready var Burger = get_tree().get_first_node_in_group("Burger")

var HasLeft = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.HasEatenBurger:
		Burger.queue_free()


func _on_area_2d_body_entered(_body):
	if HasLeft:
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		StageManager.changeScene(HALLWAY_MAIN, 442, 131)
		StageManager.changeCamera(488)
		StageManager.scene_change = true


func _on_area_2d_body_exited(_body):
	HasLeft = true
	pass # Replace with function body.
