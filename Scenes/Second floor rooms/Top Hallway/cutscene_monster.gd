extends CharacterBody2D

const WALK = 40.0
const RUN = 120.0


signal touched

var playing = true
@onready var animPlayer = $AnimationPlayer
@onready var pCollide = $PhysicsCollision
@export var monitoring = false

func _process(_delta: float) -> void:
	animPlayer.play("run_left")
	if visible:
		pCollide.disabled = false
	else:
		pCollide.disabled = true
	$FlowerSprite/BodyArea.monitoring = monitoring
	

func _on_body_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and visible and !body.hiding and ((body.position - position).length() < 100):
		playing = false
		
		touched.emit()
		body.hasAttention = false
		body.find_child("AnimationTree").set("active", false)
		var scare = get_node("CanvasLayer/Node2D")
		scare.visible = true
		scare.deathTime()
		await scare.scareDone
		get_tree().change_scene_to_file("res://Scenes/Transition Scenes/deathScreen.tscn")
		StageManager.scene_change = true
