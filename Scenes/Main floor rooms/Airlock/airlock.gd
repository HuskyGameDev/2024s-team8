extends Node2D


@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var speech_sound2 = preload("res://Assets/voice_sans.mp3")
@onready var timer = get_tree().get_first_node_in_group("Timer")
@onready var toPod = get_tree().get_first_node_in_group("to_pod")
@onready var animPlayer = get_tree().get_first_node_in_group("AnimationPlayer")


var Button1 = false
var Button2 = false



const lines: Array[String] = [
	"The door is sealed shut."
]

const lines2: Array[String] = [
	"I've defeated the monster! Time to go to the command deck and head back home!"
]

const lines3: Array[String] = [
	"I definitely shouldn't go back in there! I better eject the pod and send that monster into space!"
]

const lines4: Array[String] = [
	"What am I doing? I need to eject the pod and get that monster off this ship!"
]



#turns off the monitoring of the toPod area when airlock is closed
func _ready():
	
	if PositionManager.HasDefeatedMonster && !PositionManager.HasReadEscapeText2:
		player._swap_attention()
	
	StageManager.changeCamera(488)
	
	toPod.monitoring = false
	if PositionManager.Act < 1:
		PositionManager.Act = 1
	if PositionManager.OpenedAirlock:
		animPlayer.play("closed")
		toPod.monitoring = true
	else:
		animPlayer.play("closing")
		await animPlayer.animation_finished
		toPod.monitoring = true
	
	if PositionManager.HasDefeatedMonster && !PositionManager.HasReadEscapeText2:
		PositionManager.HasReadEscapeText2 = true
		DialogManager.start_dialog(global_position, lines2, speech_sound2)
		await DialogManager.dialog_finished
		player._swap_attention()
	


#switches to the main hall scene
func _on_to_hall_body_entered(body):
	if Input.is_action_pressed("DOWN"):
		if body.name == "Player":
			if PositionManager.OpenedAirlock:
				if PositionManager.heliDistracted && !PositionManager.HasDefeatedMonster:
					player._swap_attention()
					DialogManager.start_dialog(global_position, lines4, speech_sound2)
					await DialogManager.dialog_finished
					player._swap_attention()
				else:
					var HALL = load("res://Scenes/Main floor rooms/Main Hall/hallway_main.tscn")
					$Player.hasAttention = false
					$Player/AnimationTree.set("active", false)
					StageManager.player_facing = Vector2(0,1)
					StageManager.changeScene(HALL, 76, 130)
			else:
				player._swap_attention()
				DialogManager.start_dialog(global_position, lines, speech_sound)
				await DialogManager.dialog_finished
				player._swap_attention()
				

#switches to the pod scene
func _on_to_pod_body_entered(body):
	if Input.is_action_pressed("UP"):
		if body.name == "Player":
			if PositionManager.OpenedAirlock:
				player._swap_attention()
				DialogManager.start_dialog(global_position, lines, speech_sound)
				await DialogManager.dialog_finished
				player._swap_attention()
			else:
				var POD = load("res://Scenes/Main floor rooms/Pod/pod.tscn")
				if !PositionManager.heliDistracted:
					$Player.hasAttention = false
					$Player/AnimationTree.set("active", false)
					GlobalAudioManager.door_SFX() # Plays door opening SFX
					animPlayer.play("opening") 
					await animPlayer.animation_finished
					StageManager.player_facing = Vector2(0,-1)
					StageManager.changeScene(POD, 148, 136, true)
				elif !PositionManager.HasDefeatedMonster:
					player._swap_attention()
					DialogManager.start_dialog(global_position, lines3, speech_sound2)
					await DialogManager.dialog_finished
					player._swap_attention()
				else:
					player._swap_attention()
					DialogManager.start_dialog(global_position, lines, speech_sound)
					await DialogManager.dialog_finished
					player._swap_attention()
			
