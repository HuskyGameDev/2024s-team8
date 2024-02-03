extends CharacterBody2D


var speed = 5;
var input = Vector2.ZERO;
var max_speed = 500;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta);
	
	
	pass

func move(delta):
	input = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	if input != Vector2.ZERO:
		velocity += (1500 * input * delta)
		velocity = velocity.limit_length(max_speed);

		pass
	move_and_slide();
	pass



