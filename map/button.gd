extends Button

var save_rooms = ["res://scenes/levels/save_1.tscn","res://scenes/levels/save_2.tscn","res://scenes/levels/save_3.tscn","res://scenes/levels/save_4.tscn","res://scenes/levels/save_5.tscn","res://scenes/levels/save_6.tscn","res://scenes/levels/save_7.tscn","res://scenes/levels/save_8.tscn"]

@export var id: int

func _ready() -> void:
	if id not in SaveLoad.save_file.discovered_save_rooms:
		hide()
		focus_mode = Control.FOCUS_NONE
	else:
		#print("button "+str(id))
		show()
		focus_mode = Control.FOCUS_ALL

func _on_pressed() -> void:
	print(">>> bouton pressé, id=", id)
	Globals.marker = 0
	get_tree().paused = false
	TransitionLayer.change_scene(save_rooms[id])
	Globals.teleport.emit()
	Globals.dialogue = false

func _on_focus_entered() -> void:
	$AnimatedSprite2D.show()
	show()


func _on_focus_exited() -> void:
	$AnimatedSprite2D.hide()
	hide()
