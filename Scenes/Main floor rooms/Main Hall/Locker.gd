extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var playerOccluder = get_tree().get_first_node_in_group("LightOccluder")
@onready var playerSprite = get_tree().get_first_node_in_group("PlayerSprite")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

var InLocker = false

const lines: Array[String] = [
	"I'm going to hide in this locker!"
]

const lines2: Array[String] = [
	"I'm going to leave this locker!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	if !InLocker:
		player._swap_attention()
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
		playerOccluder.hide()
		playerSprite.hide()
		InLocker = true
		
		await get_tree().create_timer(1.0).timeout
		player.InteractionOverride = true
		
	if InLocker:
		if Input.is_action_just_pressed("INTERACT"):
			DialogManager.start_dialog(global_position, lines2, speech_sound, false)
			await DialogManager.dialog_finished
			playerOccluder.show()
			playerSprite.show()
			player._swap_attention()
			InLocker = false
			player.InteractionOverride = false
		
	
