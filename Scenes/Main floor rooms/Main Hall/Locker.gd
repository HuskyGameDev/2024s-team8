extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/voice_sans.mp3")

@onready var playerOccluder = player.get_node("Lighting/LightOccluder2D")
@onready var playerSprite = player.get_node("Sprite2D")

var InLocker = false
var playerFacing = Vector2(0, 0)

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
	if !player.hiding:
		player._swap_attention()
		DialogManager.start_dialog(global_position, lines, speech_sound, false)
		await DialogManager.dialog_finished
		playerOccluder.hide()
		playerSprite.hide()
		player.hiding = true
		InLocker = true
		PositionManager.paused = false
		
		await get_tree().create_timer(1.0).timeout
		player.InteractionOverride = true
		
	if player.hiding:
		if Input.is_action_just_pressed("INTERACT"):
			if PositionManager.hasActivatedHeli and !PositionManager.hasEscapedGreenhouse:
				return
			DialogManager.start_dialog(global_position, lines2, speech_sound, false)
			await DialogManager.dialog_finished
			player.get_node("AnimationTree").set("parameters/Idle/blend_position", -PositionManager.getDirection(player.get_node("InteractionParent").rotation_degrees))
			playerOccluder.show()
			playerSprite.show()
			player._swap_attention()
			player.hiding = false
			InLocker = false
			player.InteractionOverride = false
			PositionManager.paused = false
		
