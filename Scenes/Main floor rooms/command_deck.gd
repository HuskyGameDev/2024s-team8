extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
var HasLeft = false
# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

	
func _on_interact():
	print("working")


func _on_door_body_entered(body):
	const HALLWAY_MAIN = preload("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
	if body.name == "Player":
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_MAIN, 449, 138)
		StageManager.changeCamera(488)
		StageManager.scene_change = true
