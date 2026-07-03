extends State

var boss: CharacterBody2D

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("move")
	boss.sprite.flip_h = boss.global_position.x < boss.target_position.x

func physics_update(delta):
	var direction = (boss.target_position - boss.global_position).normalized()
	boss.velocity.x = direction.x * boss.speed
	var dist = boss.global_position.distance_to(boss.target_position)
	if dist < 50.0:
		Transitioned.emit(self, "attack")

func exit() -> void:
	boss.velocity = Vector2.ZERO
