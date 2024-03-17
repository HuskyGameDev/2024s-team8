extends Node


@onready var text_box_scene = preload("res://Dialog/text_box.tscn")

var dialog_lines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var sfx: AudioStream

var is_dialog_active = false
var can_advance_line = false
var is_interactable = false
var is_automated = false

signal dialog_finished()


func start_dialog(position: Vector2, lines: Array[String], speech_sfx: AudioStream, 
	interactable := false, automated := false):
	
	if is_dialog_active:
		return
	
	dialog_lines = lines
	sfx = speech_sfx
	is_interactable = interactable
	is_automated = automated
	show_text_box()
	
	is_dialog_active = true

func show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(on_text_box_finished_displaying)
	get_tree().get_first_node_in_group("CanvasLayer").add_child(text_box)
	text_box.display_text(dialog_lines[current_line_index], sfx)
	can_advance_line = false

func on_text_box_finished_displaying():
	can_advance_line = true

func _process(delta):
	if is_automated && is_dialog_active && can_advance_line:
		can_advance_line = false
		await get_tree().create_timer(0.5).timeout
		if text_box != null:
			text_box.queue_free()
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			dialog_finished.emit()
			return
			
		show_text_box()
		
		

func _unhandled_input(event):
	if !is_automated:
		if (
			(event.is_action_pressed("INTERACT")) &&
			is_dialog_active &&
			can_advance_line
		):
			if !is_interactable:
				text_box.queue_free()
				
				current_line_index += 1
				if current_line_index >= dialog_lines.size():
					is_dialog_active = false
					current_line_index = 0
					dialog_finished.emit()
					return
				
			show_text_box()
			
		
	if (
		is_automated &&
		event.is_action_pressed("MENU") &&
		is_dialog_active
	):
		text_box.queue_free()
		is_dialog_active = false
		current_line_index = 0
		#await get_tree().create_timer(0.01).timeout
		dialog_finished.emit()
		return
		
	


