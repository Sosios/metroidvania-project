extends CanvasLayer

@onready var label: Label = $MarginContainer2/Label
@onready var boss_label: Label = $BossHealth/Label
@onready var boss_progress_bar: ProgressBar = $BossHealth/ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(Engine.get_frames_per_second())
	update_health()
	update_boss()
	Globals.connect("stat_change",update_health)
	Globals.connect("boss_update",update_boss)
	SaveLoad.save_file.connect("update",update_health)
	get_parent().connect("update",update_health)

func update_health():
	$ProgressBar2.value = Globals.health
	$ProgressBar2.max_value = SaveLoad.save_file.max_health
	$Label.text = str(int(Globals.health))+"/"+str(int(SaveLoad.save_file.max_health))
	$ProgressBar.value = SaveLoad.save_file.exp_points
	$ProgressBar.min_value = SaveLoad.save_file.lvl_exp_cap
	$ProgressBar.max_value = SaveLoad.save_file.nxtlvl

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
