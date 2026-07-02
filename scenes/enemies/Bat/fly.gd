extends State

@export var bat :CharacterBody2D

func enter():
	bat.navigation_agent_2d.path_desired_distance = 4.0
	bat.navigation_agent_2d.target_desired_distance = 4.0
	bat.navigation_agent_2d.target_position = Globals.player_pos
	bat.sprite.flip_h = bat.global_position.x > bat.navigation_agent_2d.target_position.x
	bat.sprite.play("fly")
	bat.connect("exit", exit_area)
	bat.connect("hit_taken", damaged)
	bat.hurt_box.monitoring = true
	bat.navigation_timer.start()
	
func damaged():
	Transitioned.emit(self,"hit")
	
func exit_area():
	Transitioned.emit(self,"idle")
	
func physics_update(_delta):
	var next_path_pos = bat.navigation_agent_2d.get_next_path_position()
	var direction = (next_path_pos - bat.global_position).normalized()
	bat.velocity = direction * bat.speed
	bat.move_and_slide()


func _on_navigation_timer_timeout() -> void:
	bat.navigation_agent_2d.target_position = Globals.player_pos
	bat.sprite.flip_h = bat.global_position.x > bat.navigation_agent_2d.target_position.x
