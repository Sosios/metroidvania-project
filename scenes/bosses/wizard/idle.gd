extends State

var boss: CharacterBody2D

var timer: float

func _ready() -> void:
	boss = get_parent().get_parent()

func enter():
	boss.velocity.x = 0.0
	timer = 1.0
	boss.sprite.play("idle")
	
	
func update(delta):
	timer -= delta
	if timer <= 0:
		Transitioned.emit(self, "move")
