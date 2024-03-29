extends Control

@onready var wink = get_tree().get_first_node_in_group("MrCleanWink")
@onready var player = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1).timeout
	wink.show()
	await get_tree().create_timer(1).timeout
	wink.hide()
	await get_tree().create_timer(1).timeout
	queue_free()
	
