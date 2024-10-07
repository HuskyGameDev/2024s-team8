extends Node2D

@onready var animPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animPlayer.play("flyAway")


func _on_animation_player_animation_finished(_anim_name) -> void:
	PositionManager.HasDefeatedMonster = true
	var airLock = load("res://Scenes/Main floor rooms/Airlock/airlock.tscn")
	
	StageManager.changeScene(airLock, PositionManager.lastKnownPos.x, PositionManager.lastKnownPos.y)
	StageManager.changeCamera(304)
