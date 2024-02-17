extends Control

func _on_resume_pressed():
	queue_free()
	
func _on_quit_pressed():
	get_tree().quit()

func _process(_delta):
	if Input.is_action_just_pressed("MENU"):
		_on_resume_pressed()
