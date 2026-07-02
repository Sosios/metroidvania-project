@tool
extends Path2D

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@export var path_time := 1.0:
	set(value):
		if get_child_count() > 0 and value != null:
			path_time = value
			move_tween()
@export var ease_type: Tween.EaseType:
	set(value):
		if get_child_count() > 0 and value != null:
			ease_type = value
			move_tween()
@export var transition: Tween.TransitionType:
	set(value):
		if get_child_count() > 0 and value != null:
			transition = value
			move_tween()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path_follow_2d = $PathFollow2D
	for platform in $Platforms.get_children():
		platform.hide()
		platform.get_children()[0].disabled = true
	$Platforms.get_child(int(type)).show()
	$Platforms.get_child(int(type)).get_children()[0].disabled = false
	$PathFollow2D/RemoteTransform2D.remote_path = $Platforms.get_children()[int(type)].get_path()
	move_tween()
	
@export_enum("0","1","2") var type = "0":
	set(value):
		if get_child_count() > 0 and value != null:
			type = value
			for platform in $Platforms.get_children():
				platform.hide()
				platform.get_children()[0].disabled = true
			$Platforms.get_child(int(type)).show()
			$Platforms.get_child(int(type)).get_children()[0].disabled = false
			$PathFollow2D/RemoteTransform2D.remote_path = $Platforms.get_child(int(type)).get_path()
			move_tween()

func move_tween():
	if not is_inside_tree() or Engine.is_editor_hint():
		return
	var tween = create_tween().set_loops()
	tween.tween_property(path_follow_2d,"progress_ratio",1,path_time).set_ease(ease_type).set_trans(transition)
	tween.tween_property(path_follow_2d,"progress_ratio",0,path_time).set_ease(ease_type).set_trans(transition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
