extends Node
class_name Level
@onready var camera_2d: Camera2D = $Player/Camera2D

@onready var player: CharacterBody2D = $Player



var platform_scene = preload("res://scenes/objects/platform.tscn")

var map_scene = preload("res://map/map.tscn")

var is_map = false

var map : Node

signal update


var paused = false


func _ready() -> void:
	player.position = $TransitionPoints.get_children()[Globals.marker].position
	player.sprite.flip_h = Globals.flip_h
	player.connect("create_platform",_on_create_platform)
	if Globals.jump_up:
		$Player/StateMachine.current_state = $Player/StateMachine/Jump
		$Player/StateMachine/Jump.enter()
	Globals.stop = true
	await get_tree().create_timer(0.2).timeout
	Globals.stop = false
	update.emit()

func _input(event: InputEvent) -> void:
	pass

func _on_create_platform():
	var platform = platform_scene.instantiate()
	platform.position = player.position
	$Platforms.add_child.call_deferred(platform)
	await get_tree().create_timer(2).timeout
	platform.queue_free()
