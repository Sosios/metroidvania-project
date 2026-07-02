extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var id: int = 0

@export_enum("0","1","2") var type = "0":
	set(value):
		if get_child_count() > 0 and value != null:
			type = value

func _ready():
	if id in SaveLoad.save_file.opened_doors:
		collision_shape_2d.position.y = -48
		sprite.position.y = -48
	else:
		if id not in SaveLoad.save_file.unlocked_doors:
			if type == "1":
				$AnimationPlayer.play_backwards("open")
	
func _process(_delta: float) -> void:
	if type != "0":
		if id not in SaveLoad.save_file.opened_doors:
			if id in SaveLoad.save_file.unlocked_doors:
				$AnimationPlayer.play("open")
				SaveLoad.save_file.opened_doors.append(id)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if type == "0":
		if id not in SaveLoad.save_file.opened_doors:
			$AnimationPlayer.play("open")
			SaveLoad.save_file.opened_doors.append(id)
		
