extends Node2D

@onready var animation = get_node("AnimationPlayer")
func _ready():
	await animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Transition Scenes/endscene.tscn")
	
