extends Node2D

@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
var once = false

const lines: Array[String] = [
	"I've turned off the security. 
	The ships command deck is now unlocked, 
	lets get out of here!"
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(488)

	#while (StageManager.scene_change == true):
		#$Player.hasAttention = !StageManager.scene_change
		#$Player/AnimationTree.set("active", !StageManager.scene_change)
	#$Player.hasAttention = !StageManager.scene_change
	#$Player/AnimationTree.set("active", !StageManager.scene_change)

	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_to_first_floor_body_entered(body):
	if body.name == "Player" && Input.is_action_pressed("DOWN"):
		if PositionManager.Act == 2:
			PositionManager.Act = 3
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		StageManager.changeScene(HALLWAY_MAIN, 134, 113)

		StageManager.on_first_floor = true


func _on_to_second_floor_body_entered(body):
	if body.name == "Player" && Input.is_action_pressed("DOWN"):
		$Player.hasAttention = StageManager.scene_change
		$Player/AnimationTree.set("active", StageManager.scene_change)
		var HALL = load("res://Scenes/Second floor rooms/Top Hallway/hallway_top.tscn")
		StageManager.changeScene(HALL, 265, 117)
		StageManager.on_first_floor = false


func _on_starea_body_entered(_body):
	if once:
		$Player.onStairs = true;
	else:
		once = !once


func _on_starea_body_exited(_body):
	$Player.onStairs = false
