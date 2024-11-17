extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
const engineHumming = preload("res://Assets/Audio/Music/BED_shipengine_LP.wav")


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	StageManager.changeCamera(488)




func _on_interact():
	if PositionManager.HasDefeatedMonster:
		get_tree().change_scene_to_file("res://Scenes/Transition Scenes/outro.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Transition Scenes/deathScreen.tscn")


func _on_door_body_entered(body):
	if Input.is_action_pressed("LEFT") or Input.is_action_pressed("UP"):
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		if body.name == "Player":
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			StageManager.player_facing = Vector2(-1,0)
			StageManager.changeScene(HALLWAY_MAIN, 455, 130)
			StageManager.changeCamera(488)
