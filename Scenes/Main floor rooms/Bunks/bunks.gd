extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(488)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(_body):
	if Input.is_action_pressed("DOWN"):
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		StageManager.changeScene(HALLWAY_MAIN, 225, 119)
		StageManager.scene_change = true


func _on_area_2d_body_exited(_body):
	
	pass # Replace with function body.


func _on_to_supply_closet_body_entered(body: Node2D) -> void:
	if Input.is_action_pressed("RIGHT") && body.name == "Player":
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		var SUPPLY_CLOSET = load("res://Scenes/Main floor rooms/Supply Closet/supply_closet.tscn")
		StageManager.changeScene(SUPPLY_CLOSET, 111, 108)
		StageManager.changeCamera(304)
		StageManager.scene_change = true
		
	pass # Replace with function body.
