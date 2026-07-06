extends State

var boss: CharacterBody2D

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("move")
	boss.sprite.flip_h = boss.global_position.x > boss.target_position.x
func physics_update(delta):
	
	var direction = sign(boss.target_position.x - boss.global_position.x)
	boss.velocity.x = direction * boss.speed
	var dist = boss.global_position.x -boss.target_position.x
	if boss.is_on_wall():
		Transitioned.emit(self, "idle")
	if dist < 150.0:
		Transitioned.emit(self, ["attackpeck", "attackray","attackice"][randi() % 3])

func exit() -> void:
	boss.velocity = Vector2.ZERO
