extends Control

@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect
@onready var label: Label = $HBoxContainer/Label
@onready var amount: Label = $HBoxContainer/Label2
@onready var arrow: SubViewportContainer = $HBoxContainer/SubViewportContainer


@onready var button_2: Button = $NinePatchRect/MarginContainer/VBoxContainer/Button2
@onready var button_2_label: Label = $NinePatchRect/MarginContainer/VBoxContainer/Button2/Label

@onready var button_3: Button = $NinePatchRect/MarginContainer/VBoxContainer/Button3
@onready var button_3_label: Label = $NinePatchRect/MarginContainer/VBoxContainer/Button3/Label

signal description

signal update_weapon

signal update_armor

signal use_heal

var item_selected : InvSlot

func _ready():
	$NinePatchRect.hide()

# Called when the node enters the scene tree for the first time.
func update(slot: InvSlot):
	if slot == null:
		visible = false
		item_selected = null
		return
	if !slot.item or slot.amount == 0:
		visible = false
		focus_mode = Control.FOCUS_NONE
	else:
		visible = true
		texture_rect.texture = slot.item.texture
		label.text = slot.item.name
		amount.text = str(slot.amount)
		focus_mode = Control.FOCUS_ALL
		item_selected = slot
		
		if item_selected.item.type in ["sword","armor"]:
			button_2_label.text = "Equiper"
		else:
			button_2_label.text = "Utiliser"
		#if slot.item.name == SaveLoad.weapon.name:
			#button_3.focus_mode = Control.FOCUS_NONE
			#button_3_label.label_settings.font_color = "878787"
		#else:
			#button_3.focus_mode = Control.FOCUS_ALL
			#button_3_label.label_settings.font_color = "90625d"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_focus_entered() -> void:
	arrow.show()
	description.emit(item_selected)


func _on_focus_exited() -> void:
	arrow.hide()
	

func _input(event: InputEvent) -> void:
	if $NinePatchRect.visible == true and Input.is_action_just_released("ui_cancel"):
		$AnimationPlayer.play_backwards("menu")
		focus_mode = Control.FOCUS_ALL
		grab_focus()

func _on_pressed() -> void:
	if item_selected:
		$AnimationPlayer.play("menu")
		button_2.grab_focus()
		focus_mode = Control.FOCUS_NONE


func _on_button_2_pressed() -> void:
	if item_selected.item.type == "sword":
		SaveLoad.save_file.weapon = item_selected.item
		update_weapon.emit()
		$AnimationPlayer.play_backwards("menu")
	elif item_selected.item.type == "armor":
		SaveLoad.save_file.armor = item_selected.item
		update_armor.emit()
	elif item_selected.item.type == "heal":
		Globals.health += item_selected.item.heal
		SaveLoad.save_file.throw(item_selected.item)
	$AnimationPlayer.play_backwards("menu")
	grab_focus()
	update(item_selected)
	focus_mode = Control.FOCUS_ALL


func _on_button_3_pressed() -> void:
	if item_selected.item != SaveLoad.save_file.weapon:
		SaveLoad.save_file.throw(item_selected.item)


func _on_button_3_focus_entered() -> void:
	button_3_label.label_settings.font_color = "4A2928"


func _on_button_3_focus_exited() -> void:
	button_3_label.label_settings.font_color = "90625d"


func _on_button_2_focus_entered() -> void:
	button_2_label.label_settings.font_color = "4A2928"


func _on_button_2_focus_exited() -> void:
	button_2_label.label_settings.font_color = "90625d"
