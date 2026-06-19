extends CanvasLayer

var pause = false
@onready var slots: Array = $TabContainer/Container2/MarginContainer/VBoxContainer/HBoxContainer/GridContainer.get_children()

@onready var level_label: Label = $TabContainer/Container2/NinePatchRect2/MarginContainer/VBoxContainer/Niveau/Label2
@onready var xp_label: Label = $TabContainer/Container2/NinePatchRect2/MarginContainer/VBoxContainer/Experience/Label2
@onready var attack_label: Label = $TabContainer/Container2/NinePatchRect2/MarginContainer/VBoxContainer/Attaque2/Label2
@onready var defense_label: Label = $TabContainer/Container2/NinePatchRect2/MarginContainer/VBoxContainer/Défense/Label2

@onready var description_label: Label = $TabContainer/Container2/NinePatchRect3/Label


func _ready() -> void:
	visible = false
	get_tree().paused = false
	$AnimationPlayer.play("right")
	SaveLoad.save_file.connect("update",update_slots)
	update_slots()
	for slot_member in slots:
		slot_member.connect("update_weapon",update_slots)
		slot_member.connect("description",change_description)

func resume():
	get_tree().paused = false
	hide()
	
func paused():
	get_tree().paused = true
	show()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if pause:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true
			if $TabContainer.current_tab == 0:
				$TabContainer/Container/MarginContainer/VBoxContainer/Resume.grab_focus()
			else:
				var item_slots = slots.filter(func(slot):return slot.visible == true)
				if !item_slots.is_empty():
					item_slots[0].grab_focus()
				else:
					$TabContainer/Container2/Left.grab_focus()
			update_slots()
		pause = !pause
		print(get_tree().paused)

func update_slots():
	for i in range(min(SaveLoad.save_file.slots.size(),slots.size())):
		slots[i].update(SaveLoad.save_file.slots[i])
	$TabContainer/Container2/EquippedWeapon/WeaponSprite.texture = SaveLoad.save_file.weapon.texture
	$TabContainer/Container2/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/TextureRect/Sprite2D.material.set_shader_parameter("output_palette_texture",SaveLoad.save_file.weapon.palette)
	attack_label.text = str(int(SaveLoad.save_file.weapon.attack + SaveLoad.save_file.attack))
	if SaveLoad.save_file.armor:
		defense_label.text = str(int(SaveLoad.save_file.armor.defense + SaveLoad.save_file.defense))
	else:
		defense_label.text = str(int(SaveLoad.save_file.defense))
	xp_label.text = str(int(SaveLoad.save_file.exp_points))
	level_label.text = str(SaveLoad.save_file.level)

func change_description(item):
	description_label.text = str(item.item.description)

func _on_resume_pressed() -> void:
	resume()
	pause = false


func _on_quit_pressed() -> void:
	get_tree().quit(0)
	

func _on_right_pressed() -> void:
	$TabContainer.current_tab = 1
	slots[0].grab_focus()



func _on_left_pressed() -> void:
	$TabContainer.current_tab = 0
	$TabContainer/Container/MarginContainer/VBoxContainer/Resume.grab_focus()
