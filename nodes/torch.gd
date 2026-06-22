@tool
extends Node2D

func _ready():
	for option in $Options.get_children():
		option.hide()
	$Options.get_child(int(type)).show()

@export_enum("0","1","2") var type = "0":
	set(value):
		if get_child_count() > 0 and value != null:
			type = value
			for option in $Options.get_children():
				option.hide()
			$Options.get_child(int(type)).show()
@export_color_no_alpha var color = Color(0.0, 1.0, 1.0, 1.0):
	set(value):
		color = value
		$PointLight2D.color = color
@export var energy = 1.0:
	set(value):
		energy = value
		$PointLight2D.energy = energy
@export var tex_scale = 1.0:
	set(value):
		tex_scale = value
		$PointLight2D.texture_scale = tex_scale

func _process(_delta):
	pass
