extends State

var timer: float

@export var skeleton: CharacterBody2D 

func enter():
	timer = 0.1
	skeleton = get_parent().get_parent()
	skeleton.sprite.play("crouch_reload")
	skeleton.animation_player.play("crouch_reload")
	skeleton.direction = sign(Globals.player_pos.x - skeleton.global_position.x)
	skeleton.sprite.flip_h = skeleton.direction == -1
	skeleton.velocity.x = 0.0
	if not skeleton.hit_taken.is_connected(_on_hit_taken):
		skeleton.hit_taken.connect(_on_hit_taken)

func _on_hit_taken():
	Transitioned.emit(self,"hit")

func transition():
	skeleton.arrow = true
	if skeleton.detect:
		Transitioned.emit(self,["getup","crouch_attack"][randi() % 2])
	else:
		Transitioned.emit(self,"idle")
