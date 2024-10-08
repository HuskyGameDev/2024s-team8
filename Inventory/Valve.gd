extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var minigameScene = preload("res://Minigames/Valve Game/ValveGame.tscn")
@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")

var minigame = null

signal clear_fog()

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	if minigame == null and !PositionManager.HasClearedValve:
		minigame = minigameScene.instantiate()
		Canvas.add_child(minigame)
		minigame.completed.connect(_on_completed)
		player.ValveMinigame = true
		player._swap_attention()
	pass

func _on_completed():
	clear_fog.emit()
	
