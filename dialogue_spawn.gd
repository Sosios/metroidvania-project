extends Area2D

@export_enum("on_ready","on_collision") var type = "on_ready"

@export var dialogue: Dialogue

@export var id: int

@export var add_character:= false

@export var add_gravity := false

@export var add_dash := false

@export var add_platform := false

@export var end_game := false

signal dialogue_box(title,text,face)

signal info_box(title,text)

var current_dialogue: int = 0

func _ready() -> void:
	Globals.connect("next_dialogue", play_next)
	await get_tree().process_frame
	if type == "on_ready" and dialogue.dialogue[0] and id not in SaveLoad.save_file.discovered_dialogues:
		Globals.dialogue = true
		if Globals.stop:
			await Globals.transition_finished
		send_dialogue(0)

func send_dialogue(current):
	get_tree().paused = true
	if dialogue.dialogue[current].type == "dialogue":
		dialogue_box.emit(dialogue.dialogue[current].title,dialogue.dialogue[current].text,dialogue.dialogue[current].face)
		#print("dialogue emit")
	if dialogue.dialogue[current].type == "info":
		info_box.emit(dialogue.dialogue[current].title,dialogue.dialogue[current].text)
		#print("info emit")

func play_next():
	current_dialogue += 1
	if current_dialogue == dialogue.dialogue.size():
		queue_free()
		get_tree().paused = false
		Globals.dialogue = false
		SaveLoad.save_file.discovered_dialogues.append(id)
		if add_character:
			SaveLoad.save_file.characters_unlocked += 1
		if add_dash:
			SaveLoad.save_file.can_dash = true
		if add_gravity:
			SaveLoad.save_file.can_gravity = true
		if add_platform:
			SaveLoad.save_file.can_platform  = true
	else:
		send_dialogue(current_dialogue)



func _on_body_entered(body: Node2D) -> void:
	if type == "on_collision" and id not in SaveLoad.save_file.discovered_dialogues:
		Globals.dialogue = true
		send_dialogue(0)
