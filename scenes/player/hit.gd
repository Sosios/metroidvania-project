extends State
class_name PlayerHit

var player: CharacterBody2D

var timer:float

var direction

func ready():
	player = get_player()

func enter():
	player = get_player()
	player.attack_1_area.monitoring = false
	direction = (player.global_position - player.hit_global_position).normalized()
	print(direction)
	Globals.health -= player.hit_damage
	Globals.stop = true
	player.sprite.play("hit")
	player.general_ap.play("hit")
	timer = 0.2
	player.velocity = Vector2(direction.x, -0.5).normalized()*200
	
func physics_update(delta):
	timer -= delta
	if timer <= 0:
		Globals.stop = false
		Transitioned.emit(self,"idle")
