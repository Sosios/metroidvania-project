extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction:float = 1

func _ready():
	sprite.flip_h = direction < 0

func _process(delta: float) -> void:
	position.x += direction * 200 * delta

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
		return
	if "hurt" in body:
		body.hurt(250.0,global_position)
	
