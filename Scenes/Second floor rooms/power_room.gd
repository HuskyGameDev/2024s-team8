extends Node2D

var count = 0
@onready var animPlayer = $AnimationPlayer

func _ready():
	if PositionManager.Act == 1 and animPlayer != null:
		$Player._swap_attention()
		$Player/AnimationPlayer.play("Left")
		animPlayer.play("Enter Act 2")
		await animPlayer.animation_finished
		animPlayer.play("Wake up")
		await animPlayer.animation_finished
		$Player._swap_attention()
	else:
		print("Pooey")

func _on_door_body_entered(_body):
	count += 1
	if count > 1:
		const HALLWAY_TRANS = preload("res://Scenes/Second floor rooms/hallway_transition.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false) 
		StageManager.changeScene(HALLWAY_TRANS, 72, 132)
		StageManager.changeCamera(304)
		StageManager.scene_change = true
