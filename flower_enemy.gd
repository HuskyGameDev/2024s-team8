extends CharacterBody2D

@export var facing = true
@export var speed = 360
var pursuiting = false
var pursuitant

signal touched()

func _process(_delta: float) -> void:
	get_node("FlowerSprite").flip_h = facing

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if pursuitant != null:
		velocity.y = pursuitant.position.y - position.y
		velocity.x = pursuitant.position.x - position.x

		velocity = velocity.normalized()
		move_and_collide(velocity * delta * speed)

func _on_vision_cone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pursuitant = body
	
func _on_vision_cone_body_exited(_body: Node2D) -> void:
	pursuitant = null

func _on_body_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and false:
		touched.emit()
		body.hasAttention = false
		body.find_child("AnimationTree").set("active", false)
		var scare = get_node("CanvasLayer/Node2D")
		scare.deathTime()
		await scare.scareDone
		get_tree().change_scene_to_file("res://Scenes/Transition Scenes/deathScreen.tscn")
		StageManager.scene_change = true
