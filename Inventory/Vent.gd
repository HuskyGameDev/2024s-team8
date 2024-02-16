extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var label = player.get_child(3)

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	pass # Replace with function body.


func _on_interact():
	if player.HasCrowbar:
		queue_free()
		label.hide()
	else:
		label.global_position = player.global_position
		label.global_position.y -= 150
		label.global_position.x -= label.size.x / 2
		label.show()
		await get_tree().create_timer(3.0).timeout
		label.hide()
		pass
	pass
