extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var crowbar = get_tree().get_first_node_in_group("Crowbar")

# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(488)
	if PositionManager.HasCrowbar:
		crowbar.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#sets the direction the character will be facing in the next scene
func _on_area_2d_body_entered(_body):
	if Input.is_action_pressed("DOWN") && _body.name == "Player":
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		StageManager.player_facing = Vector2(0,1)
		StageManager.changeScene(HALLWAY_MAIN, 403, 120)
		StageManager.changeCamera(488)



func _on_area_2d_body_exited(_body):
	pass # Replace with function body.

#sets the direction the character will be facing in the next scene
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if Input.is_action_pressed("LEFT") && body.name == "Player":
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		var BUNK = load("res://Scenes/Main floor rooms/Bunks/bunks.tscn")
		StageManager.player_facing = Vector2(-1,0)
		StageManager.changeScene(BUNK, 273, 130)
		StageManager.changeCamera(304)

	pass # Replace with function body.
