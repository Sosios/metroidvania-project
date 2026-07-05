extends State

var timer: float

@export var skeleton: CharacterBody2D 

func enter():
	timer = 0.1
	skeleton = get_parent().get_parent()
	skeleton.sprite.play("crouch")
	skeleton.animation_player.play("crouch")
	skeleton.direction = sign(Globals.player_pos.x - skeleton.global_position.x)
	skeleton.sprite.flip_h = skeleton.direction == -1
	skeleton.velocity.x = 0.0
	if not skeleton.hit_taken.is_connected(_on_hit_taken):
		skeleton.hit_taken.connect(_on_hit_taken)

func _on_hit_taken():
	Transitioned.emit(self,"hit")

func transition():
	if skeleton.detect:
		if skeleton.arrow:
			Transitioned.emit(self,"crouch_attack")
		else:
			Transitioned.emit(self,"crouch_reload")
	else:
		Transitioned.emit(self,"getup")
