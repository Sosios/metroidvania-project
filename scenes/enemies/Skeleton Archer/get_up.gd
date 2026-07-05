extends State

var timer: float

@export var skeleton: CharacterBody2D 

func enter():
	timer = 0.1
	skeleton = get_parent().get_parent()
	skeleton.sprite.play_backwards("crouch")
	skeleton.animation_player.play("getup")
	skeleton.direction = sign(Globals.player_pos.x - skeleton.global_position.x)
	skeleton.sprite.flip_h = skeleton.direction == -1
	if not skeleton.hit_taken.is_connected(_on_hit_taken):
		skeleton.hit_taken.connect(_on_hit_taken)

func _on_hit_taken():
	Transitioned.emit(self,"hit")

func transition():
	if skeleton.detect:
		if skeleton.arrow:
			Transitioned.emit(self,"attack")
		else:
			Transitioned.emit(self,"reload")
	else:
		Transitioned.emit(self,"idle")
