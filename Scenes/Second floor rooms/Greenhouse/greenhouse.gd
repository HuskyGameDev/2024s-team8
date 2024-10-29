extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_to_hallway_body_entered(body: Node2D) -> void:
	if (Input.is_action_pressed("LEFT") or Input.is_action_pressed("UP")) && body.name == "Player":
		var HALLWAY = load("res://Scenes/Second floor rooms/Top Hallway/hallway_top.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(-1,0)
		StageManager.changeScene(HALLWAY, 456, 128)
		StageManager.changeCamera(480)
