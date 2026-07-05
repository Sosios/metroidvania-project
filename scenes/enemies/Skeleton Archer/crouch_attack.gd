extends State

var timer: float

var skeleton: CharacterBody2D 

func enter():
	timer = 0.1
	skeleton = get_parent().get_parent()
	skeleton.sprite.play("crouch_attack")
	skeleton.animation_player.play("crouch_attack")
	skeleton.direction = sign(Globals.player_pos.x - skeleton.global_position.x)
	skeleton.sprite.flip_h = skeleton.direction == -1
	if not skeleton.hit_taken.is_connected(_on_hit_taken):
		skeleton.hit_taken.connect(_on_hit_taken)

func _on_hit_taken():
	Transitioned.emit(self,"hit")

func transition():
	skeleton.arrow = false
	if skeleton.detect:
		Transitioned.emit(self,["crouch_reload","getup"][randi() % 2])
	else:
		Transitioned.emit(self,"getup")
