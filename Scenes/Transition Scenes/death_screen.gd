extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_texture_button_pressed():
	get_tree().quit()


func _on_texture_button_2_pressed() -> void:
	#retrying when they died in act two should send them to the power room with the power turned off and the monster hidden
	if PositionManager.Act == 2:
		var POWER_ROOM = load("res://Scenes/Second floor rooms/Power Room/power_room.tscn")
		PositionManager.Act = 1
		PositionManager.hasActivatedHeli = false
		PositionManager.hasClearedPipe = false
		PositionManager.hasEscapedGreenhouse = false
		StageManager.player_facing = Vector2(0,1)
		StageManager.changeScene(POWER_ROOM, 220, 115)
		StageManager.changeCamera(312)
		pass
	else:
		#if they died in act 3 should send them to the security room with all of the items not picked up
		var SECURITY_ROOM = load("res://Scenes/Second floor rooms/Security Room/security_room.tscn")
		if PositionManager.HasHeatLamp:
			#take heat lamp out of inventory
			PositionManager.Inventory.erase("HeatLamp")
			PositionManager.InventoryText.erase("A heating device")
			PositionManager.InventorySprite.erase("res://Assets/Inventory Icons/inventory-lamp.png")
			PositionManager.HasHeatLamp = false
			
		if PositionManager.HasMeat:
			#take meat out of inventory
			PositionManager.Inventory.erase("Meat")
			PositionManager.InventoryText.erase("A piece of raw meat")
			PositionManager.InventorySprite.erase("res://Assets/Inventory Icons/inventory-meat.png")
			PositionManager.HasMeat = false
		if PositionManager.HasSpaceSuit:
			#take space suit out of inventory
			PositionManager.Inventory.erase("SpaceSuit")
			PositionManager.InventoryText.erase("A spare spacesuit")
			PositionManager.InventorySprite.erase("res://Assets/Inventory Icons/inventory-suit.png")
			PositionManager.HasSpaceSuit = false

		if PositionManager.hasDecoy:
			PositionManager.hasDecoy = false
		
		StageManager.player_facing = Vector2(0,1)
		StageManager.changeScene(SECURITY_ROOM, 90, 138)
		StageManager.changeCamera(304)
		StageManager.scene_change = true
