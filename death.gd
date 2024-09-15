extends Node2D

signal scareDone()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Sprite2D").visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func deathTime() -> void:
	get_node("Sprite2D").visible = true
	var player = get_node("AnimationPlayer")
	player.play("rising_action")
	await player.animation_finished
	player.play("climax")
	await get_tree().create_timer(1.0).timeout
	scareDone.emit()
