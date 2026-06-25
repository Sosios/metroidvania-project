extends Marker2D

@export var boss: PackedScene

@export var id: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if id not in SaveLoad.save_file.defeated_bosses:
		var boss_instance = boss.instantiate()
		add_child(boss_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
