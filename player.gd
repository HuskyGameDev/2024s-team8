extends CharacterBody2D

@export var playerSpeed = 350
@onready var animation = get_node("AnimatedSprite2D")
@export var pauseMenu : PackedScene

var screen_size
var hasAttention = true
var HasCrowbar = false
var pause

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = StageManager.player_position
	get_node("Camera2D").limit_right = StageManager.camera_limit

func _swap_attention():
	#print("Before: "+str(hasAttention))
	hasAttention = !hasAttention
	#print("Before: "+str(hasAttention))

func _process(_delta):
	if hasAttention:
		if Input.is_action_just_pressed("MENU"):
			pause = pauseMenu.instantiate()
			$PauseLayer.add_child(pause)
			pause.tree_exited.connect(_swap_attention)
			_swap_attention()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO
	move_and_collide(velocity)
	if hasAttention:
		if Input.is_action_pressed("RIGHT"):
			velocity.x += 1
			animation.play("Walk_Right")
		if Input.is_action_pressed("LEFT"):
			velocity.x -= 1
			animation.play("Walk_Left")
		if Input.is_action_pressed("DOWN"):
			velocity.y += 1
			animation.play("Walk_Backward")
		if Input.is_action_pressed("UP"):
			velocity.y -= 1
			animation.play("Walk_Forward")
				
			
		if Input.is_action_just_released("DOWN") or Input.is_action_just_released("UP") or Input.is_action_just_released("LEFT") or Input.is_action_just_released("RIGHT"):
			animation.stop()

		if velocity.length() > 0:
			velocity = velocity.normalized() * playerSpeed
	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
