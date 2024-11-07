extends CanvasLayer


func hide_crt():
	visible = false

func show_crt():
	visible = true


func _process(_delta: float) -> void:
	if PositionManager.crt_effect == 0:
		hide_crt()
	else:
		show_crt()
