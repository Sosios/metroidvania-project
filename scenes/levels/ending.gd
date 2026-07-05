extends Level



func _ready() -> void:
	update.emit()
	player.position = $TransitionPoints.get_children()[Globals.marker].position
	player.sprite.flip_h = Globals.flip_h
	player.hide()
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
	

func show_dialogue(dialogue_spawn):
	get_tree().paused = true
	var dialogue = spawn_scene.instantiate()
	dialogue.type = "on_ready"
	dialogue.dialogue = dialogue_spawn
	canvas_layer.add_child(dialogue)

func create_dialogue_box(title,text,face):
	get_tree().paused = true
	var dialogue = dialogue_scene.instantiate()
	canvas_layer.add_child(dialogue)
	dialogue.dialogue_name.text = title
	dialogue.text.text = text
	dialogue.face.texture = face
	
func create_info_box(title,text):
	get_tree().paused = true
	var info = info_scene.instantiate()
	canvas_layer.add_child(info)
	info.title.text = title
	info.text.text = text
	#print(">>> info size=", info.size, " info rect global=", info.get_global_rect())

func create_arrow(pos,damage):
	var direction = sign(Globals.player_pos.x - pos.x)
	var choice = randi_range(0,1)
	var arrow = arrow_scene.instantiate()
	arrow.direction = direction
	arrow.global_position = pos
	arrow.damage = damage
	$Platforms.add_child.call_deferred(arrow)

func cast_spell(pos):
	var direction = sign(Globals.player_pos.x - pos.x)
	var choice = randi_range(0,1)
	if choice == 0:
		for i in range(3):
			var random_range = randf_range(-5, 5)
			var fire = fire_scene.instantiate()
			fire.direction = direction
			fire.global_position = pos + Vector2(20*direction,-30 + random_range)
			$Platforms.add_child.call_deferred(fire)
			await get_tree().create_timer(1).timeout
		
	else:
		for i in range(3):
			var random_range = randf_range(-100.0, 100.0)
			var lightning = lightning_scene.instantiate()
			lightning.global_position.x = Globals.player_pos.x + random_range
			lightning.global_position.y = 225
			$Platforms.add_child.call_deferred(lightning)

func create_cube(pos):
	var ice_cube = ice_cube_scene.instantiate()
	ice_cube.position = player.position
	$Platforms.add_child.call_deferred(ice_cube)


func _on_create_platform():
	var platform = platform_scene.instantiate()
	platform.position = player.position
	$Platforms.add_child.call_deferred(platform)
	await get_tree().create_timer(2).timeout
	platform.queue_free()
