extends CanvasLayer

@onready var label: Label = $MarginContainer2/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(Engine.get_frames_per_second())
	update_health()
	Globals.connect("stat_change",update_health)
	SaveLoad.save_file.connect("update",update_health)
	get_parent().connect("update",update_health)

func update_health():
	$ProgressBar2.value = Globals.health
	$ProgressBar2.max_value = SaveLoad.save_file.max_health
	$Label.text = str(int(Globals.health))+"/"+str(int(SaveLoad.save_file.max_health))
	$ProgressBar.value = SaveLoad.save_file.exp_points
	$ProgressBar.min_value = SaveLoad.save_file.lvl_exp_cap
	$ProgressBar.max_value = SaveLoad.save_file.nxtlvl

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	label.text = str(Engine.get_frames_per_second())
