extends Node2D


func _ready() -> void:
	PositionManager.ViewedWallMap = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MENU"):
		_on_full_map_exit_pressed()


func _on_full_map_exit_pressed() -> void:
	queue_free()
