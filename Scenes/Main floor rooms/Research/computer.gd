extends Node2D

@onready var Canvas = get_tree().get_first_node_in_group("CanvasLayer")
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var speech_sound = preload("res://Assets/Dialogue blip5.mp3")

var currentFile = 0

const lines: Array[String] = [
	"Report H3-L1, Dave A:",
	"I returned to the lab this morning to find a cheeseburger left under a heat lamp.",
	"At least it's in a wrapper this time. And on a plate.",
	"I need to have a chat with Doug about acceptable lab usage...",
	"Interestingly, Specimen H3-L1 seems to be extending a vine towards the burger.",
	"I'll run it through the decontaminator; mark it 'NOT SAFE TO EAT'...",
	"...and replace it here to see what the specimen does.",
	"Personal Note: I caught Lucy naming the lab rats today.",
	"I warned her that she'll get attached, and she just offered to let me help her.",
	"How could I refuse?"
]

const lines2: Array[String] = [
	"Follow-up Report H3-L1-2:",
	"The cheeseburger was consumed! I can see the foil wrapper and bun in Specimen H3-L1's pot.",
	"The creature seems to have reached out and dragged the burger into its pot...",
	"It absorbed the patty completely! All in one night!",
	"I'll inform the others of these results, and we'll discuss further experimentation and analysis.",
	"Unfortunatley, the heat lamp seems to have burned out. It's not turning on.",
	"I'll send it downstairs for Mark to fix it.",
	"I'm sure he's got the spare parts for it down in the boiler room."
]

const lines3: Array[String] = [
	"Follow-follow-up Report H3-L1-3:",
	"Upon further experimentation, we have determined that Specimen H3-L1 appears to favor warm foods.",
	"Exclusively meat...",
	"The creature is clearly a carnivorous species; however, unlike Earth plants, there is no clear lure or trap.",
	"It is certainly capable of retrieving unmoving meat, but at first glance that seems inefficient.",
	"No creature would sit still long enough to be grabbed like that...",
	"Further experimentation necessary."
]

const lines4: Array[String] = [
	"Follow-follow-follow-up Report \nH3-L1-4:",
	"I've checked the security footage for the lab. Doug kept insisting he locked the rat cages.",
	"We decided to pull the footage to settle the matter.",
	"He was right... the cages were locked when he left. They were unlocked afterwards.",
	"Specimen H3-L1... climbed out of its pot. It unlocked one of the cages.",
	"It grabbed one of the rats and...",
	"We've sealed it in a climate-controlled chamber for now.",
	"We have... so many questions. Mostly 'How?' and 'Why?'",
	"Further reports to follow."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	player._swap_attention()
	if currentFile == 0:
		DialogManager.start_dialog(global_position, lines, speech_sound, false, false)
		await DialogManager.dialog_finished
		if PositionManager.Documents.find("Report H3-L1") == -1:
			PositionManager.Documents.append("Report H3-L1")
			PositionManager.DocumentsText.append(PositionManager.array_to_string(lines))
			PositionManager.DocumentsPaper.append(false)
			PositionManager.play_notification("Document")
	elif currentFile == 1:
		DialogManager.start_dialog(global_position, lines2, speech_sound, false, false)
		await DialogManager.dialog_finished
		if PositionManager.Documents.find("Report H3-L1-2") == -1:
			PositionManager.Documents.append("Report H3-L1-2")
			PositionManager.DocumentsText.append(PositionManager.array_to_string(lines2))
			PositionManager.DocumentsPaper.append(false)
			PositionManager.play_notification("Document")
	elif currentFile == 2:
		DialogManager.start_dialog(global_position, lines3, speech_sound, false, false)
		await DialogManager.dialog_finished
		if PositionManager.Documents.find("Report H3-L1-3") == -1:
			PositionManager.Documents.append("Report H3-L1-3")
			PositionManager.DocumentsText.append(PositionManager.array_to_string(lines3))
			PositionManager.DocumentsPaper.append(false)
			PositionManager.play_notification("Document")
	elif currentFile == 3:
		DialogManager.start_dialog(global_position, lines4, speech_sound, false, false)
		await DialogManager.dialog_finished
		if PositionManager.Documents.find("Report H3-L1-4") == -1:
			PositionManager.Documents.append("Report H3-L1-4")
			PositionManager.DocumentsText.append(PositionManager.array_to_string(lines4))
			PositionManager.DocumentsPaper.append(false)
			PositionManager.play_notification("Document")
		currentFile = -1
	currentFile += 1
	player._swap_attention()
