extends Node2D

@export var randomStrength: float = 0.5
@export var shakeFade: float = 3.0
@export var shaking = false

@onready var camera = get_tree().current_scene.get_node("Player").get_node("Camera2D")

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0


func _ready():
	shaking = false

func apply_shake():
	shake_strength = randomStrength

func _process(delta):
	if shaking:
		apply_shake()
	
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shakeFade * delta)
		camera.offset = randomOffset()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
