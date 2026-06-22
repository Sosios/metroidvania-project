extends Node

signal stat_change
signal pos_change

var player_pos

var direction = 1

var attack_1_times := [0.5,0.4162,0.4162]
var attack_2_times := [0.332,0.5,0.25]
var attack_3_times := [0.5,0.6664]


var damage = 10

var jump_up = false

var current_room = 0:
	set(value):
		current_room = value
		pos_change.emit()

var stop = false

var health = 100:
	set(value):
		if value > health:
			health = min(value,SaveLoad.save_file.max_health)
		elif value < health:
			var raw_damage = health - value
			var real_damage = max(raw_damage - SaveLoad.save_file.defense, 1)
			health -= real_damage
		else:
			health = value
		stat_change.emit()

var marker = 0

var flip_h: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
