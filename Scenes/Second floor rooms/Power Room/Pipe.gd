extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var minigameScene = load("res://Minigames/Pipe Game/PipeGame.tscn")
@onready var minigameScene2 = load("res://Minigames/Pipe Game 2/PipeGame2.tscn")
@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var PipePuzzle = get_tree().get_first_node_in_group("PipePuzzle")

var minigame = null

signal opening

# Called when the node enters the scene tree for the first time.
func _ready():
	if PositionManager.hasClearedPipe:
		interaction_area.queue_free()
	if PositionManager.PipeVersion == 1:
		minigameScene = minigameScene2
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	if minigame == null:
		await get_tree().create_timer(0.001).timeout
		minigame = minigameScene.instantiate()
		Canvas.add_child(minigame)
		minigame.cleared.connect(_on_cleared)
		player._swap_attention()
	pass

func _on_cleared():
	PositionManager.hasClearedPipe = true
	PositionManager.Act = 2
	opening.emit()
	PipePuzzle.queue_free()
