extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#DOES NOT WORK, MESSING AROUND
#func _setCameraLimits(left, right, top, bottom):
#	#change camera limits
#	var cam 
#	cam.limit_left = 0
#	cam.limit_right = 496
#	cam.limit_top = 0
#	cam.limit_bottom.set(160)


func _on_mess_hall_body_entered(body):
	const MESS = preload("res://Scenes/Main floor rooms/mess_hall.tscn")
	if body.name == "Player":
		StageManager.changeScene(MESS, 232, 120)


func _on_research_room_body_entered(body):
	const RESEARCH = preload("res://Scenes/Main floor rooms/research1.tscn")
	if body.name == "Player":
		StageManager.changeScene(RESEARCH, 80, 128)


func _on_pod_body_entered(body):
	const POD = preload("res://Scenes/Main floor rooms/pod.tscn")
	if body.name == "Player":
		pass#StageManager.changeScene(POD, 232, 120) code for when scene exists


func _on_bunks_body_entered(body):
	const BUNKS = preload("res://Scenes/Main floor rooms/bunks.tscn")
	if body.name == "Player":
		StageManager.changeScene(BUNKS, 240, 144)


func _on_supply_closet_body_entered(body):
	const SUPPLY = preload("res://Scenes/Main floor rooms/supply_closet.tscn")
	if body.name == "Player":
		StageManager.changeScene(SUPPLY, 128, 120)
