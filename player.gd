extends Area2D

@export var playerSpeed = 250
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The Player's movement vector
	if Input.is_action_pressed("RIGHT"):
		velocity.x += 1
	if Input.is_action_pressed("LEFT"):
		velocity.x -= 1
	if Input.is_action_pressed("DOWN"):
		velocity.y += 1
	if Input.is_action_pressed("UP"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * playerSpeed
	else:
		pass

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
