extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var minigameScene = preload("res://Minigames/ValveGame.tscn")
@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")

var minigame = null

# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(1000)
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	if minigame == null:
		minigame = minigameScene.instantiate()
		Canvas.add_child(minigame)
		player.ValveMinigame = true
		player._swap_attention()
	pass
