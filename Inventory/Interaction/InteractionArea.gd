extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"

var interact: Callable = func():
	pass

func _on_body_entered(body):
	if body.name == "Player":
		print("player entered")
		InteractionManager.register_area(self)
	pass # Replace with function body.


func _on_body_exited(body):
	if body.name == "Player":
		print("player left")
		InteractionManager.unregister_area(self)
	pass # Replace with function body.

