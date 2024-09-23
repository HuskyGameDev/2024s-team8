extends GridContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i = 0
	for x in PositionManager.InventoryText:
		get_child(i).text = x
		get_child(i).texture = load(PositionManager.Inventory[i])
		i = i + 1
