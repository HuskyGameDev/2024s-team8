extends Node2D


@export var usingMarker2 = false
@export var leavingRoom = false

@onready var marker = $Marker2D
@onready var marker2 = $Marker2D2
@onready var player = get_node("Player")


func _ready() -> void:
	player.backingUp = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
		if Input.is_action_just_pressed("MENU"):
			leave_room()
	if player.animMove && !usingMarker2:
		var vector = Vector2.ZERO
		var x = marker.position.x - player.position.x
		var y = marker.position.y - player.position.y
	
		if absf(x) > 0.4:
			vector.x = x
		if absf(y) > 0.4:
			vector.y = y
			
		player.animVec = vector
	elif player.animMove && usingMarker2:
		player.playerSpeed = 125
		var vector = Vector2.ZERO
		var x = marker2.position.x - player.position.x
		var y = marker2.position.y - player.position.y
	
		if absf(x) > 0.5:
			vector.x = x
		if absf(y) > 0.5:
			vector.y = y
			
		player.animVec = vector
	
	if leavingRoom:
		leave_room()

func _swap_marker():
	usingMarker2 = true

func toggle_animMove():
	player.animMove = !player.animMove

func _on_to_hallway_body_entered(body: Node2D) -> void:
	if (Input.is_action_pressed("LEFT") or Input.is_action_pressed("UP")) && body.name == "Player":
		var HALLWAY = load("res://Scenes/Second floor rooms/Top Hallway/hallway_top.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(-1,0)
		StageManager.changeScene(HALLWAY, 456, 128)
		StageManager.changeCamera(480)
	elif body.name == "Player" && !player.hasAttention:
		leave_room()

func leave_room( ):
	var HALLWAY = load("res://Scenes/Second floor rooms/Top Hallway/hallway_top.tscn")
	$Player.hasAttention = false
	$Player/AnimationTree.set("active", false)
	StageManager.player_facing = Vector2(-1,0)
	StageManager.changeScene(HALLWAY, 456, 128)
	StageManager.changeCamera(480)
