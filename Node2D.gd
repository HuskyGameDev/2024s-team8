extends Node2D


var speed = 5;
var input = Vector2.ZERO;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta);
	
	
	pass

func move(delta):
	input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity += (input * accel * delta)
	velocity 
	pass




