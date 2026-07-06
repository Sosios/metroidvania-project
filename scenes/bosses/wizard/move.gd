extends State

var boss: CharacterBody2D

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("run")
	boss.target_position = Globals.player_pos
	boss.sprite.flip_h = boss.global_position.x > boss.target_position.x

func physics_update(delta):
	var direction = sign(boss.target_position.x - boss.global_position.x)
	boss.velocity.x = direction * boss.speed
	var dist = abs(boss.global_position.x - boss.target_position.x)
	#print(dist)
	if boss.is_on_wall():
		Transitioned.emit(self, "idle")
	if dist < 150.0:
		Transitioned.emit(self, ["attack1", "attack2","cast"][randi() % 3])

func exit() -> void:
	boss.velocity = Vector2.ZERO
