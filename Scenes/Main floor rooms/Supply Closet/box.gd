extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

@onready var playerOccluder = player.get_node("Lighting/LightOccluder2D")
@onready var playerSprite = player.get_node("Sprite2D")


const lines: Array[String] = [
	"A large supply box.",
	"You notice some cleaning supplies scattered across the bottom."
]

const lines2: Array[String] = [
	"I'm going to hide in this box!"
]

const lines3: Array[String] = [
	"I'm going to stop hiding in this box!"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	if PositionManager.Act != 3:
		player._swap_attention()
		DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
		await DialogManager.dialog_finished
		player._swap_attention()
	else:
		if !player.hiding:
			player._swap_attention()
			DialogManager.start_dialog(global_position, lines2, speech_sound, false)
			await DialogManager.dialog_finished
			playerOccluder.hide()
			playerSprite.hide()
			$BoxOpen.hide()
			$BoxClosed.show()
			player.hiding = true
			
			await get_tree().create_timer(1.0).timeout
			player.InteractionOverride = true
			
		if player.hiding:
			if Input.is_action_just_pressed("INTERACT"):
				DialogManager.start_dialog(global_position, lines3, speech_sound, false)
				await DialogManager.dialog_finished
				player.get_node("AnimationTree").set("parameters/Idle/blend_position", -PositionManager.getDirection(player.get_node("InteractionParent").rotation_degrees))
				playerOccluder.show()
				playerSprite.show()
				$BoxClosed.hide()
				$BoxOpen.show()
				player._swap_attention()
				player.hiding = false
				player.InteractionOverride = false
