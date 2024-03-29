extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var minigameScene = preload("res://Minigames/PipeGame.tscn")
@onready var Canvas = get_tree().get_first_node_in_group("Canvas")

var minigame = null

# Called when the node enters the scene tree for the first time.
func _ready():
	StageManager.changeCamera(1000)
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	if minigame == null:
		await get_tree().create_timer(0.001).timeout
		minigame = minigameScene.instantiate()
		Canvas.add_child(minigame)
		minigame.cleared.connect(_on_cleared)
		#player.ValveMinigame = true
		player._swap_attention()
	pass

func _on_cleared():
	PositionManager.hasClearedPipe = true
	PositionManager.Act = 2
	queue_free()
