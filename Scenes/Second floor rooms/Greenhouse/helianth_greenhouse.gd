extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var animPlayer = $MonsterPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.hasActivatedHeli:
		set_visible(false)
		queue_free()
	else:
		interaction_area.interact = Callable(self, "_on_interact")
	


func _on_interact():
	if !PositionManager.hasActivatedHeli:
		PositionManager.hasActivatedHeli = true
		if player.hasAttention:
			player.hasAttention = false
		
		animPlayer.play("Jumpscare")
	
	


func _on_monster_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Jumpscare":
		animPlayer.play("IdleTransition")
	if anim_name == "IdleTransition":
		animPlayer.play("Idle")
		if !player.hasAttention:
			player.hasAttention = true
