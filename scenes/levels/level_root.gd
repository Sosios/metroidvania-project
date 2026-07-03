extends Node
class_name Level
@onready var camera_2d: Camera2D = $Player/Camera2D

@onready var player: CharacterBody2D = $Player


var ice_cube_scene = preload("res://assets/Boss/Pengu/ice_cube.tscn")
var platform_scene = preload("res://scenes/objects/platform.tscn")

signal update



func _ready() -> void:
	update.emit()
	player.position = $TransitionPoints.get_children()[Globals.marker].position
	player.sprite.flip_h = Globals.flip_h
	for boss in get_tree().get_nodes_in_group("Bosses"):
		boss.connect("ice_cube", create_cube)
	player.connect("create_platform",_on_create_platform)
	if Globals.jump_up:
		$Player/StateMachine.current_state = $Player/StateMachine/Jump
		$Player/StateMachine/Jump.enter()
	if Globals.dash:
		$Player/StateMachine.current_state = $Player/StateMachine/Dash
		$Player/StateMachine/Dash.enter()
	Globals.stop = true
	await get_tree().create_timer(0.2).timeout
	Globals.stop = false
	


func create_cube(pos):
	var ice_cube = ice_cube_scene.instantiate()
	ice_cube.position = player.position
	$Platforms.add_child.call_deferred(ice_cube)

func _process(_delta: float) -> void:
	$CanvasModulate.color = Globals.screen_color

func _on_create_platform():
	var platform = platform_scene.instantiate()
	platform.position = player.position
	$Platforms.add_child.call_deferred(platform)
	await get_tree().create_timer(2).timeout
	platform.queue_free()
