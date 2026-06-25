extends State
class_name GolluxMove

var boss: CharacterBody2D

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("move")
	boss.sprite.flip_h = boss.global_position.x > boss.target_position.x
	var sign = -1.0 if boss.sprite.flip_h else 1.0
	for hitbox in boss.hitboxes:
		hitbox.position.x = abs(hitbox.position.x) * sign
func physics_update(delta):
	var direction = (boss.target_position - boss.global_position).normalized()
	boss.velocity.x = direction.x * boss.speed
	var dist = boss.global_position.distance_to(boss.target_position)
	if dist < 50.0:
		Transitioned.emit(self, ["attack1", "attack2"][randi() % 2])

func exit() -> void:
	boss.velocity = Vector2.ZERO
