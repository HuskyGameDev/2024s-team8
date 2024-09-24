extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
var HasLeft = false
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	StageManager.changeCamera(488)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

	
func _on_interact():
	get_tree().change_scene_to_file("res://Scenes/Transition Scenes/outro.tscn")


func _on_door_body_entered(body):
	if Input.is_action_pressed("LEFT"):
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		if body.name == "Player":
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.changeScene(HALLWAY_MAIN, 462, 130)
			StageManager.changeCamera(488)
			StageManager.scene_change = true
