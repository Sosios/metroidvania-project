extends Node

signal stat_change
signal pos_change
signal boss_update

var screen_color:Color = Color(1.0, 1.0, 1.0, 1.0)

var player_pos: Vector2

signal boss_spell_cast(pos)

signal next_dialogue

signal transition_finished

var direction = 1

var attack_1_times := [0.5,0.4162,0.4162]
var attack_2_times := [0.332,0.5,0.25]
var attack_3_times := [0.5,0.6664]

var dialogue := false

var damage = 10

var jump_up = false

var current_room = 0:
	set(value):
		current_room = value
		pos_change.emit()

var stop = false

var show_bar: bool = false:
	set(value):
		show_bar = value
		boss_update.emit()

var boss_health: float:
	set(value):
		boss_health = value
		boss_update.emit()

var boss_name: String = ""

var boss_max_health: float

var shake: bool = false

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

var dash = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
