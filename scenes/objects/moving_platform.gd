extends Path2D

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@export var path_time := 1.0
@export var ease_type: Tween.EaseType
@export var transition: Tween.TransitionType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_tween()

func move_tween():
	var tween = create_tween().set_loops()
	tween.tween_property(path_follow_2d,"progress_ratio",1,path_time).set_ease(ease_type).set_trans(transition)
	tween.tween_property(path_follow_2d,"progress_ratio",0,path_time).set_ease(ease_type).set_trans(transition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
