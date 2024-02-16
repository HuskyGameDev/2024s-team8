extends CharacterBody2D

@export var playerSpeed = 350
var screen_size
@onready var animation = get_node("AnimatedSprite2D")

var HasCrowbar = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The Player's movement vector
	if Input.is_action_just_pressed("MENU"):
		get_tree().quit()
	if Input.is_action_pressed("RIGHT"):
		velocity.x += 1
		if velocity.x == 1:
			animation.play("Walk_Right")
	if Input.is_action_pressed("LEFT"):
		velocity.x -= 1
		if velocity.x == -1:
			animation.play("Walk_Left")
	if Input.is_action_pressed("DOWN"):
		velocity.y += 1
		if velocity.y == 1:
			animation.play("Walk_Backward")
	if Input.is_action_pressed("UP"):
		velocity.y -= 1
		if velocity.y == -1:
			animation.play("Walk_Forward")
	if velocity.y == 0 and velocity.x == 0:
		animation.stop()
	#print(velocity.y)
	if velocity.length() > 0:
		velocity = velocity.normalized() * playerSpeed
	else:
		pass
	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)

	
	
	
	
