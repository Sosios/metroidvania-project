extends CanvasLayer

@onready var label: Label = $MarginContainer2/Label
@onready var boss_label: Label = $BossHealth/Label
@onready var boss_progress_bar: TextureProgressBar = $BossHealth/ProgressBar
@onready var timer_value: ProgressBar = $TimerValue

@onready var characters := $HBoxContainer.get_children()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(Engine.get_frames_per_second())
	update_health()
	update_boss()
	Globals.connect("stat_change",update_health)
	Globals.connect("boss_update",update_boss)
	Globals.connect("timer",update_timer)
	SaveLoad.save_file.connect("update",update_health)
	get_parent().get_parent().connect("update",update_health)

func update_health():
	$HealthBar.value = Globals.health
	$HealthBar.max_value = SaveLoad.save_file.max_health
	$Health.text = str(int(Globals.health))
	$MaxHealth.text = "/"+str(int(SaveLoad.save_file.max_health))
	$ExpBar.value = SaveLoad.save_file.exp_points
	$ExpBar.min_value = SaveLoad.save_file.lvl_exp_cap
	$ExpBar.max_value = SaveLoad.save_file.nxtlvl
	$Label.text = str(SaveLoad.save_file.level)
	for i in range(3):
		if i > SaveLoad.save_file.characters_unlocked:
			characters[i].hide()
		else:
			characters[i].show()
		characters[i].border_color = Color(1.0, 1.0, 1.0, 1.0)
	characters[SaveLoad.save_file.player_selected].border_color = Color(1.0, 0.0, 0.0, 1.0)

func update_timer():
	timer_value.max_value = Globals.timer_length
	timer_value.value = Globals.elapsed_time

func update_boss():
	if Globals.show_bar:
		$BossHealth.show()
		boss_label.text = Globals.boss_name
		boss_progress_bar.max_value = Globals.boss_max_health
		boss_progress_bar.value = Globals.boss_health
	else:
		$BossHealth.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	label.text = str(Engine.get_frames_per_second())
