extends Node2D

@export var time = 1
@export var minBright = 0.1
@export var maxBright = 1.0
@onready var bulb = get_child(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
	#if bulb != null:
		#var rand = randf_range(minBright, maxBright)
		#var coin = randi_range(0,time)
		#if coin == 0:
			#bulb.energy = rand
