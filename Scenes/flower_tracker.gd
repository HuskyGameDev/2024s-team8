extends CharacterBody2D

const WALK = 40.0
const RUN = 120.0


signal touched

var playing = true

@onready var pCollide = $PhysicsCollision
@export var dir := Vector2()
@export var walkin = true

var erased = false

func _process(_delta: float) -> void:
	
	if PositionManager.HasDefeatedMonster and !erased:
		erased = true
		queue_free()

func _physics_process(_delta: float) -> void:
	
	if playing:
		# Movement vector
		dir = dir.normalized()
		if walkin:
			dir *= WALK
		else:
			dir *= RUN
		velocity = dir

		move_and_slide()
