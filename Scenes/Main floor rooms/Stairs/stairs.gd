extends Node2D

@onready var path = $FlowerPath
@onready var flower = $Flower
@onready var stairsOffset = Vector2(400 - 376, 144 - 160)
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

var once = false

const lines: Array[String] = [
	"I've turned off the security. 
	The ships command deck is now unlocked, 
	lets get out of here!"
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	path.visible = false
	flower.visible = false
	flower.position = path.points[PositionManager.destOrder[PositionManager.dest]] - PositionManager.HelianthRelativePosition
	PositionManager.paused = false
	if PositionManager.destOrder[PositionManager.dest] > 8 or PositionManager.destOrder[PositionManager.dest] < 3:
		flower.visible = false
	else:
		flower.visible = true
		flower.monitoring = true
	StageManager.changeCamera(488)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if !PositionManager.paused:
		moving()
	else:
		flower.dir = Vector2.ZERO


func moving():
	
	var destCoord = path.points[PositionManager.destOrder[PositionManager.dest]]
	PositionManager.HelianthRelativePosition = destCoord - flower.position
	if PositionManager.HelianthRelativePosition.length() < 1.5:
		if PositionManager.destOrder[PositionManager.dest] == 3 or PositionManager.destOrder[PositionManager.dest] == 8:
			flower.visible = !flower.visible
		PositionManager.dest += 1
		PositionManager.dest = PositionManager.dest % PositionManager.destOrder.size()
		
	flower.dir = PositionManager.HelianthRelativePosition
	
	await get_tree().create_timer(1.0).timeout

func _on_to_first_floor_body_entered(body):
	if body.name == "Player" && Input.is_action_pressed("DOWN"):
		if PositionManager.Act == 2:
			PositionManager.Act = 3
		PositionManager.paused = true
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		var HALLWAY_MAIN = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
		StageManager.player_facing = Vector2(0, 1)
		StageManager.changeScene(HALLWAY_MAIN, 134, 113)
		StageManager.on_first_floor = true


func _on_to_second_floor_body_entered(body):
	if body.name == "Player" && Input.is_action_pressed("DOWN"):
		$Player.hasAttention = StageManager.scene_change
		PositionManager.paused = true
		$Player/AnimationTree.set("active", StageManager.scene_change)
		var HALL = load("res://Scenes/Second floor rooms/Top Hallway/hallway_top.tscn")
		StageManager.player_facing = Vector2(0, 1)
		StageManager.changeScene(HALL, 265, 117)
		StageManager.on_first_floor = false


func _on_starea_body_entered(body):
	if body.name == "Player":
		$Player.onStairs = true;


func _on_starea_body_exited(body):
	if body.name == "Player":
		$Player.onStairs = false
