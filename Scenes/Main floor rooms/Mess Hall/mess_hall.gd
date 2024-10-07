extends Node2D

@onready var player = $"%Player"
@onready var serveAreaLeft = $"%ServingAreaLeft"
@onready var serveAreaRight = $"%ServingAreaRight"

# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(488)
	


func _process(delta):
	if player.position.x < 90:
		serveAreaLeft.visible = true
		serveAreaRight.visible = false
	else:
		serveAreaRight.visible = true
		serveAreaLeft.visible = false



#switches to main hall
#sets the direction the character will be facing in the next scene
func _on_to_main_body_entered(body: Node2D) -> void:
		if Input.is_action_pressed("UP"):
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
			StageManager.player_facing = Vector2(0,-1)
			StageManager.changeScene(HALLWAY_MAIN, 180, 143)
			StageManager.changeCamera(488)

#switches to main hall
#sets the direction the character will be facing in the next scene
func _on_to_main_left_body_entered(body: Node2D) -> void:
		if Input.is_action_pressed("UP"):
			$Player.hasAttention = false
			$Player/AnimationTree.set("active", false)
			var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
			StageManager.player_facing = Vector2(0,-1)
			StageManager.changeScene(HALLWAY_MAIN, 54, 143)
			StageManager.changeCamera(488)
