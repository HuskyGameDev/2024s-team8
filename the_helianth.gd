extends CharacterBody2D

const WALK = 40.0
const RUN = 120.0


signal touched

var playing = true

@onready var animPlayer = $AnimationPlayer
@onready var pCollide = $PhysicsCollision
@export var dir := Vector2()
@export var walkin = true
@export var monitoring = false

func _process(_delta: float) -> void:
	if visible:
		pCollide.disabled = false
	else:
		pCollide.disabled = true
	$FlowerSprite/BodyArea.monitoring = monitoring
		

func _physics_process(_delta: float) -> void:
	
	if playing:
		# Movement vector
		dir = dir.normalized()
		if walkin:
			dir *= WALK
		else:
			dir *= RUN
		velocity = dir
		
		# Movement Animation
		if walkin:
			if velocity.x > 0:
				animPlayer.play("walk_right")
			elif velocity.x < 0:
				animPlayer.play("walk_left")
			else:
				animPlayer.stop()
		else:
			if velocity.x > 0:
				animPlayer.play("run_right")
			elif velocity.x < 0:
				animPlayer.play("run_left")
			else:
				animPlayer.stop()

		move_and_slide()

func _on_body_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and visible and !body.hiding and ((body.position - position).length() < 100) and false:
		playing = false
		animPlayer.stop()
		touched.emit()
		body.hasAttention = false
		body.find_child("AnimationTree").set("active", false)
		var scare = get_node("CanvasLayer/Node2D")
		scare.visible = true
		scare.deathTime()
		await scare.scareDone
		get_tree().change_scene_to_file("res://Scenes/Transition Scenes/deathScreen.tscn")
		StageManager.scene_change = true


func _on_vision_cone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$VisionCone.monitoring = false
		if walkin:
			playing = false
			if velocity.x > 0:
				animPlayer.play("spot_right")
			elif velocity.x < 0:
				animPlayer.play("spot_left")
			await animPlayer.animation_finished
			playing = true
		$VisionCone.monitoring = true
		walkin = false
		await get_tree().create_timer(5.0).timeout
		walkin = true
		
