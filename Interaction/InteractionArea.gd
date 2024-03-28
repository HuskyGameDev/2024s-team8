extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"

var interact: Callable = func():
	pass


func _on_area_entered(area):
	if area.name == "InteractionParent":
		InteractionManager.register_area(self)
	pass # Replace with function body.


func _on_area_exited(area):
	if area.name == "InteractionParent":
		InteractionManager.unregister_area(self)
	pass # Replace with function body.
