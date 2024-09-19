extends Control

var poemCode = ['w', 'd', 'a', 'w', 'a']
var userInput = []
var lockStates = []
var currentIndex = 0
var previousIndex = -1
@onready var person = get_tree().get_first_node_in_group("Player")
@onready var player = get_node("AnimationPlayer")
@onready var state = get_node("Backplate/Outline/LockState")

signal solved()

func _ready() -> void:
	state.modulate = "FF2222"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("MENU"):
		queue_free()
		person._swap_attention()
	if Input.is_action_just_pressed("UP"):
		userInput.append('w')
	if Input.is_action_just_pressed("DOWN"):
		userInput.append('s')
	if Input.is_action_just_pressed("LEFT"):
		userInput.append('a')
	if Input.is_action_just_pressed("RIGHT"):
		userInput.append('d')
	if userInput.size() > currentIndex and previousIndex < currentIndex:
		previousIndex = currentIndex
		lockProcess()

func lockProcess() -> void:
	await playAnim(userInput[currentIndex])
	if userInput.size() > currentIndex:
		if poemCode[currentIndex] == userInput[currentIndex]:
			lockStates.append(0)
		else:
			lockStates.append(1)
		currentIndex += 1
		
	if currentIndex == 5:
		if lockStates.all(func(element): return element == 0):
			print("Success!")
			state.modulate = "22FF22"
			await get_tree().create_timer(1).timeout
			solved.emit()
			person._swap_attention()
			queue_free()
		else:
			print("You suck")
			userInput.clear()
			lockStates.clear()
			currentIndex = 0
			previousIndex = -1

func playAnim(anim: String) -> void:
	player.play(anim)
	await player.animation_finished
