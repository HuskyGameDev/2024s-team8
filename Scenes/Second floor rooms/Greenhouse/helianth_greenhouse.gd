extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")
@onready var animPlayer = $MonsterPlayer
@onready var collision = $MonsterCollision


# Called when the node enters the scene tree for the first time.
func _ready():
	player.backingUp = false
	if PositionManager.hasActivatedHeli:
		set_visible(false)
		queue_free()
	else:
		interaction_area.interact = Callable(self, "_on_interact")
	

func _process(_delta):
	
	if !player.hasAttention && (animPlayer.current_animation == "DecoyInteract" || animPlayer.current_animation == "Jumpscare")  && PositionManager.hasActivatedHeli:
		if player.position.x < position.x:
			player.backingUp = true
		else:
			player.backingUp = false
	
	if animPlayer.current_animation == "Roar":
		player.backingUp = false



func _on_interact():
	if !PositionManager.hasActivatedHeli:
		PositionManager.hasActivatedHeli = true
		if player.hasAttention:
			player.hasAttention = false
		
		collision.get_child(0).disabled = true
		animPlayer.play("DecoyInteract")
	


func _on_monster_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "DecoyInteract":
		animPlayer.play("Jumpscare")
	if anim_name == "Jumpscare":
		animPlayer.play("Roar")
	if anim_name == "Roar":
		player.backingUp = false
		animPlayer.play("Idle")
		collision.get_child(0).disabled = false
