extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	if PositionManager.HasCrowbar:
		PositionManager.HasOpenedVent = true
		get_node("Sprite2D").hide()



