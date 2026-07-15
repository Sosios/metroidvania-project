extends Control
@onready var anim: AnimationPlayer = $AnimationPlayer

@onready var zone_name: String = $Label.text:
	set(value):
		zone_name = value
		$Label.text = value

@export var new_zone: bool:
	set(value):
		new_zone = value
		Globals.new_zone = value
