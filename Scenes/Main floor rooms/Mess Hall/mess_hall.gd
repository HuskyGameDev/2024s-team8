extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(488)
	pass

func _on_to_main_body_entered(body: Node2D) -> void:
		if Input.is_action_pressed("UP"):
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
			StageManager.changeScene(HALLWAY_MAIN, 180, 143)
			StageManager.changeCamera(488)



func _on_to_main_left_body_entered(body: Node2D) -> void:
		if Input.is_action_pressed("UP"):
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
			StageManager.changeScene(HALLWAY_MAIN, 54, 143)
			StageManager.changeCamera(488)
