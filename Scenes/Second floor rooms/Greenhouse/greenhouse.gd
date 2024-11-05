extends Node2D


@export var usingMarker2 = false
@export var leavingRoom = false
var vector = Vector2.ZERO

@onready var marker = $Marker2D
@onready var marker2 = $Marker2D2
@onready var player = get_node("Player")
var x
var y

func _ready() -> void:
	player.backingUp = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(player.animMove)
	if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
		if Input.is_action_just_pressed("MENU"):
			leave_room()
	if !usingMarker2:
		x = marker.position.x - player.position.x
		y = marker.position.y - player.position.y
		vector = Vector2(x,y)
		
	player.animVec = vector
	if player.animMove && !usingMarker2:
		
		if absf(vector.x) <= 1 && absf(vector.y) <= 1:
			player.animationTree.set("parameters/Idle/blend_position", Vector2(0,1))
			player.animVec = Vector2.ZERO
			
		else:
			x = marker.position.x - player.position.x
			y = marker.position.y - player.position.y
			vector = Vector2(x,y)
		
		#player.animVec = vector
		#player.animVec = Vector2.ZERO
	elif player.animMove && usingMarker2:
		player.playerSpeed = 125
		
		if absf(vector.x) <= 1 && absf(vector.y) <= 1:
			player.animVec = Vector2.ZERO
			vector = Vector2.ZERO
		else:
			x = marker2.position.x - player.position.x
			y = marker2.position.y - player.position.y
			vector = Vector2(x,y)
		#player.animVec = vector
		#player.animVec = Vector2.ZERO
	
	

func _swap_marker():
	var x = marker2.position.x - player.position.x
	var y = marker2.position.y - player.position.y
	vector = Vector2(x,y)
	usingMarker2 = true



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
