extends Sprite2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var Player = $Player
@onready var CornerMarker = $CornerMarker

# Called when the node enters the scene tree for the first time.
#Allows player to interact with the button then starts a timer
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

#Pushes the button when the player interacts with it if they have pushed the other button
#and the airlock isnt open yet opens the airlock
func _on_interact():
	if PositionManager.Act == 3:
		var vec = Vector2()
		vec.x = CornerMarker.position.x
		vec.y = CornerMarker.position.y
		
