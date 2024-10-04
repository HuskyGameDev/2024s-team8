extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var person = get_tree().get_first_node_in_group("Player")
@onready var minigameScene = preload("res://directionalLock.tscn")
@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer2")
@onready var player = get_node("AnimationPlayer")

var minigame = null

signal open_door

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.

func _on_interact():
	if minigame == null:
		minigame = minigameScene.instantiate()
		Canvas.add_child(minigame)
		minigame.solved.connect(_on_solved)
		person.DialLock = true
		person._swap_attention()
	pass

func _on_solved():
	PositionManager.hasClearedDial = true
	interaction_area.queue_free()
	open_door.emit()
