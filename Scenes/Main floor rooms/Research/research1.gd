extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(488)
	get_node("AnimationPlayer").play("pace")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(_body):
	if Input.is_action_pressed("UP"):
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_MAIN, 260, 144)
		StageManager.changeCamera(488)
		StageManager.scene_change = true


func _on_door_to_hallway_body_exited(_body):
	pass # Replace with function body.


func _on_flower_touched() -> void:
	get_node("AnimationPlayer").active = false


func _on_to_hall_right_body_entered(body: Node2D) -> void:
	if Input.is_action_pressed("UP"):
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.changeScene(HALLWAY_MAIN, 414, 150)
		StageManager.changeCamera(488)
		StageManager.scene_change = true
	pass # Replace with function body.
