extends CharacterBody2D

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var lights = $CanvasModulate
@onready var CodeNotif = $PauseLayer/TextEdit
@onready var animationState = animationTree.get("parameters/playback")
@onready var objectiveMenu = preload("res://Scripts/ObjectivesMenu.tscn")
@onready var InteractionParent = get_tree().get_first_node_in_group("InteractionParent")
@onready var CanvasModulateObject = get_tree().get_first_node_in_group("CanvasModulate") #Red filter canvas modulate (just CanvasModulate)
@onready var NoiseModulateObject = get_tree().get_first_node_in_group("NoiseModulate")
@export var playerSpeed = 350
@export var pauseMenu : PackedScene
@export var mini_map : PackedScene
@export var mini_map_2nd_floor : PackedScene
@export var hasAttention = true
@export var onStairs = false
var screen_size
var pause
var ValveMinigame = false
var ComboLock = false
var emergencyLights = "3f0000"
var normalLights = "ffffff"
var InteractionOverride = false


# Called when the node enters the scene tree for the first time.
func _ready():
	lights.show()
	screen_size = get_viewport_rect().size
	if StageManager.player_position != Vector2.ZERO:
		position = StageManager.player_position
	if PositionManager.StartFromBeginning:
		get_node("Camera2D").limit_right = StageManager.right_camera_limit
	animationTree.set("active", true)

func _swap_attention():
	hasAttention = !hasAttention
	animationTree.set("active", hasAttention)

func _process(_delta):
	if PositionManager.Act == 1:
		lights.color = emergencyLights
	elif PositionManager.Act != 1:
		lights.color = normalLights
	if PositionManager.HasNote:
		if !PositionManager.hasClearedCombo:
			CodeNotif.visible = true
			CodeNotif.text = "Security Code: " + str(PositionManager.comboCode)
		else:
			CodeNotif.visible = false
	if hasAttention:
		if Input.is_action_just_pressed("MENU"):
			pause = pauseMenu.instantiate()
			$PauseLayer.add_child(pause)
			pause.tree_exited.connect(_swap_attention)
			_swap_attention()
			if ValveMinigame == true:
				ValveMinigame = false
		if Input.is_action_just_pressed("OBJECTIVE"):
			var objectives = objectiveMenu.instantiate()
			$PauseLayer.add_child(objectives)
			objectives.tree_exited.connect(_swap_attention)
			_swap_attention()
		if StageManager.on_first_floor == true:
			if Input.is_action_just_pressed("MAP"):
				var map = mini_map.instantiate()
				$PauseLayer.add_child(map)
				map.tree_exited.connect(_swap_attention)
				_swap_attention()
				if ValveMinigame == true:
					ValveMinigame = false
		elif StageManager.on_first_floor == false:
			if Input.is_action_just_pressed("MAP"):
				var map = mini_map_2nd_floor.instantiate()
				$PauseLayer.add_child(map)
				map.tree_exited.connect(_swap_attention)
				_swap_attention()
				if ValveMinigame == true:
					ValveMinigame = false
				if ComboLock == true:
					ComboLock = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO
	move_and_collide(velocity)
	
	if Input.is_action_just_pressed("SHIFT"):
			playerSpeed += 20
	if Input.is_action_just_released("SHIFT"):
			playerSpeed -= 20
	if hasAttention:
		if Input.is_action_pressed("DOWN"):
			velocity.y += 1
			InteractionParent.rotation_degrees = 270
			InteractionParent.get_child(0).rotation_degrees = 270
			
		if Input.is_action_pressed("UP"):
			velocity.y -= 1
			InteractionParent.rotation_degrees = 90
			InteractionParent.get_child(0).rotation_degrees = 90
			
		if Input.is_action_pressed("RIGHT"):
			velocity.x += 1
			InteractionParent.rotation_degrees = 180
			InteractionParent.get_child(0).rotation_degrees = 180
	
		if Input.is_action_pressed("LEFT"):
			velocity.x -= 1
			InteractionParent.rotation_degrees = 0
			InteractionParent.get_child(0).rotation_degrees = 0
		if onStairs:
			velocity = velocity.rotated((PI)/4)
			
			
		if velocity != Vector2.ZERO:
			animationTree.set("parameters/Idle/blend_position", velocity.normalized())
			animationTree.set("parameters/Moving/blend_position", velocity.normalized())
			animationState.travel("Moving")
		else:
			animationState.travel("Idle")
			

		if velocity.length() > 0:
			velocity = velocity.normalized() * playerSpeed
	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)


