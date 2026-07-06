extends Node2D

@export var type:int = 0
@onready var map_rooms: TileMapLayer = $MapRooms
@onready var bg: TileMapLayer = $Parallax2D/BG

func _ready():
	$IndicationsDev.hide()
	$MapUI.hide()
	#Globals.connect("teleport",teleport_kill)
	
#func teleport_kill():
	#queue_free()
	
func resume():
	get_tree().paused = false
	hide()
	
func paused():
	get_tree().paused = true
	show()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("map") and not Globals.dialogue:
		if get_tree().paused:
			resume()
			$MapUI.hide()
		else:
			type = 0
			$MapRooms.zoom = true
			paused()
			$MapRooms.update()
			$MapRooms.update_discover()
			
			$MapUI.show()
