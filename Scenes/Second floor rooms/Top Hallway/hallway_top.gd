extends Node2D

var move = true

@onready var Lock = get_tree().get_first_node_in_group("Combo Lock")
@onready var SecurityDoor = get_node("dialDoor")
@onready var StairsDoor = get_tree().get_first_node_in_group("Stairs Door")
@onready var animPlayer = get_node("AnimationPlayer")
@onready var lP = $"Pathing/Left Point"
@onready var rP = $"Pathing/Right Point"
@onready var dS = $"Pathing/Door Stop"
@onready var dP = $"Pathing/Door Point"
@onready var path = $FlowerPath
@onready var flower = $Flower
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")
@onready var speech_sound2 = preload("res://Assets/Dialogue blip5.mp3")
@onready var player = get_node("Player")
@onready var monsterCutscene = $"%HelianthCutscene"
@onready var timer = $Timer
const lines: Array[String] = [
	"I need to find somewhere to hide!"
]

const lines2: Array[String] = [
	"What am I doing? I need to hide from that monster!"
]

const lines3: Array[String] = [
	"You feel like you're forgetting something..."
]


func _ready():
	
	path.visible = false
	flower.visible = false
	if PositionManager.hasClearedDial:
		if SecurityDoor != null:
			SecurityDoor.queue_free()
	else:
		animPlayer.play("closed")
	
	if !PositionManager.SecurityEnabled:
		$"Stairs Door".queue_free()
		PositionManager.paused = false
		flower.position = path.points[PositionManager.destOrder[PositionManager.dest]] - PositionManager.HelianthRelativePosition
		if PositionManager.destOrder[PositionManager.dest] > 3:
			flower.visible = false
		else:
			flower.visible = true
			flower.monitoring = true
	else:
		flower.visible = false
	
	if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
		if player.hasAttention:
			player._swap_attention()
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
		if !player.hasAttention:
			player._swap_attention()

func _process(_delta):
	if !PositionManager.SecurityEnabled:
		if !PositionManager.paused:
			moving()
		else:
			flower.dir = Vector2.ZERO
	
	if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
		await DialogManager.dialog_finished
		timer.start()
		if (player.hiding && !monsterCutscene.is_playing()) or (timer.timeout && !monsterCutscene.is_playing()):
			
			await get_tree().create_timer(1).timeout
			flower.show()
			flower.monitoring = true
			monsterCutscene.play("MonsterRunPast")
			await monsterCutscene.animation_finished
			flower.monitoring = false

func moving():
	
	var destCoord = path.points[PositionManager.destOrder[PositionManager.dest]]
	PositionManager.HelianthRelativePosition = destCoord - flower.position
	if PositionManager.HelianthRelativePosition.length() < 2:
		if PositionManager.destOrder[PositionManager.dest] == 3:
			flower.visible = !flower.visible
		PositionManager.dest += 1
		PositionManager.dest = PositionManager.dest % PositionManager.destOrder.size()
		
	flower.dir = PositionManager.HelianthRelativePosition

func _on_to_security_room_body_entered(body):
	if body.name == "Player":
		if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
			if player.hasAttention:
				player._swap_attention()
			DialogManager.start_dialog(global_position, lines2, speech_sound, false)
			await DialogManager.dialog_finished
			if !player.hasAttention:
				player._swap_attention()
			return
	if body.name == "Player" && Input.is_action_pressed("UP") && PositionManager.hasClearedDial:
		var SECURITY_ROOM = load("res://Scenes/Second floor rooms/Security Room/security_room.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(0,-1)
		StageManager.changeScene(SECURITY_ROOM, 141, 147)
		StageManager.changeCamera(304)
		StageManager.scene_change = true


func _on_to_stairs_body_entered(body):	
	if body.name == "Player":
		if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
			if player.hasAttention:
				player._swap_attention()
			DialogManager.start_dialog(global_position, lines2, speech_sound, false)
			await DialogManager.dialog_finished
			if !player.hasAttention:
				player._swap_attention()
			return
		elif !PositionManager.hasActivatedHeli:
			if player.hasAttention:
				player._swap_attention()
			DialogManager.start_dialog(global_position, lines3, speech_sound2, false)
			await DialogManager.dialog_finished
			if !player.hasAttention:
				player._swap_attention()
			return
	if body.name == "Player" && Input.is_action_pressed("UP") && !PositionManager.SecurityEnabled:
		var STAIRS = load("res://Scenes/Main floor rooms/Stairs/stairs.tscn")
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(0,-1)
		StageManager.changeScene(STAIRS, 243, 144)
		StageManager.changeCamera(312)
		StageManager.scene_change = true

func _on_combo_lock_open_door():
	GlobalAudioManager.door_SFX() # Plays door opening SFX
	#animPlayer.play("Sec_Door_Opening")


func _on_dial_door_open_door() -> void:
	GlobalAudioManager.door_SFX() # Plays door opening SFX
	animPlayer.play("opening")
	await animPlayer.animation_finished
	PositionManager.doorHasOpened = true
	animPlayer.play("open")


func _on_to_power_room_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
			if player.hasAttention:
				player._swap_attention()
			DialogManager.start_dialog(global_position, lines2, speech_sound, false)
			await DialogManager.dialog_finished
			if !player.hasAttention:
				player._swap_attention()
			return
	if Input.is_action_pressed("LEFT") && body.name == "Player":
		var POWER_ROOM = load("res://Scenes/Second floor rooms/Power Room/power_room.tscn")
		PositionManager.paused = true
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(-1,0)
		StageManager.changeScene(POWER_ROOM, 274, 122)
		StageManager.changeCamera(312)



func _on_to_boiler_room_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
			if player.hasAttention:
				player._swap_attention()
			DialogManager.start_dialog(global_position, lines2, speech_sound, false)
			await DialogManager.dialog_finished
			if !player.hasAttention:
				player._swap_attention()
			return
	if Input.is_action_pressed("UP") && body.name == "Player":
		var BOILER_ROOM = load("res://Scenes/Second floor rooms/Boiler Room/boiler_room.tscn")
		PositionManager.paused = true
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(0,-1)
		StageManager.changeScene(BOILER_ROOM, 204, 140)
		StageManager.changeCamera(304)


func _on_to_greenhouse_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if PositionManager.hasActivatedHeli && !PositionManager.hasEscapedGreenhouse:
			if player.hasAttention:
				player._swap_attention()
			DialogManager.start_dialog(global_position, lines2, speech_sound, false)
			await DialogManager.dialog_finished
			if !player.hasAttention:
				player._swap_attention()
			return
	if Input.is_action_pressed("RIGHT") && body.name == "Player":
		var GREENHOUSE = load("res://Scenes/Second floor rooms/Greenhouse/greenhouse.tscn")
		PositionManager.paused = true
		$Player.hasAttention = false
		$Player/AnimationTree.set("active", false)
		StageManager.player_facing = Vector2(1,0)
		StageManager.changeScene(GREENHOUSE, 93, 122)
		StageManager.changeCamera(304)


func _on_helianth_cutscene_animation_finished(anim_name: StringName) -> void:
	if anim_name == "MonsterRunPast":
		flower.hide()
		if PositionManager.Objectives.find("Remove Threat") == -1:
			PositionManager.add_objective("Remove Threat", "Remove the threat.")
		if PositionManager.Objectives.find("Investigate Greenhouse") != -1:
			PositionManager.remove_objective("Investigate Greenhouse")
		PositionManager.hasEscapedGreenhouse = true
		
