extends Level



func _ready() -> void:
	player.hide()
	$CanvasModulate.color = Color("ffc3ae")
	update.emit()
	player.position = $TransitionPoints.get_children()[Globals.marker].position
	player.sprite.flip_h = Globals.flip_h
	for boss in get_tree().get_nodes_in_group("Bosses"):
		boss.connect("ice_cube", create_cube)
		boss.connect("send_dialogue_spawn", show_dialogue)
	for enemy in get_tree().get_nodes_in_group("Entity"):
		enemy.connect("send_arrow", create_arrow)
	for ui in get_tree().get_nodes_in_group("UI"):
		ui.connect("dialogue_box", create_dialogue_box)
		ui.connect("info_box", create_info_box)
	Globals.boss_spell_cast.connect(cast_spell)
	player.connect("create_platform",_on_create_platform)
	if Globals.jump_up:
		$Player/StateMachine.current_state = $Player/StateMachine/Jump
		$Player/StateMachine/Jump.enter()
	if Globals.dash:
		$Player/StateMachine.current_state = $Player/StateMachine/Dash
		$Player/StateMachine/Dash.enter()
	Globals.stop = true
	await get_tree().create_timer(0.2).timeout
	Globals.stop = false


func create_dialogue_box(title,text,face):
	print(">>> create_dialogue_box appelé avec title=", title)
	var dialogue = dialogue_scene.instantiate()
	canvas_layer.add_child(dialogue)
	dialogue.dialogue_name.text = title
	dialogue.text.text = text
	dialogue.face.texture = face
	print(">>> dialogue box ajoutée, enfants canvas_layer=", canvas_layer.get_child_count())
	
func create_info_box(title,text):
	get_tree().paused = true
	var info = info_scene.instantiate()
	canvas_layer.add_child(info)
	info.title.text = title
	info.text.text = text
