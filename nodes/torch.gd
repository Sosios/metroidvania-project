@tool
extends Node2D

@onready var point_light_2d: PointLight2D = $PointLight2D


func _ready():
	for option in $Options.get_children():
		option.hide()
	$Options.get_child(int(type)).show()
	if point_light_2d:
		point_light_2d.color = color
		point_light_2d.energy = energy
		point_light_2d.texture_scale = tex_scale

@export_enum("0","1","2") var type = "0":
	set(value):
		if get_child_count() > 0 and value != null:
			type = value
			for option in $Options.get_children():
				option.hide()
			$Options.get_child(int(type)).show()
@export_color_no_alpha var color = Color("5cc6ff"):
	set(value):
		if point_light_2d:
			color = value
			point_light_2d.color = color
@export var energy = 3.0:
	set(value):
		if point_light_2d:
			energy = value
			point_light_2d.energy = energy
@export var tex_scale = 0.15:
	set(value):
		if point_light_2d:
			tex_scale = value
			point_light_2d.texture_scale = tex_scale

func _process(_delta):
	pass
