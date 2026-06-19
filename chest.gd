extends Area2D

@export var item: InvItem

@export var id : int

func _ready() -> void:
	$Label.hide()
	$Sprite2D.hide()
	update_status()
	

	
func update_status():
	$Sprite2D.texture = item.texture
	$Label.text = item.name
	if id in SaveLoad.save_file.opened_chests:
		$AnimatedSprite2D.animation = "opened"
	else:
		$AnimatedSprite2D.animation = "closed"


func _on_body_entered(body: Node2D) -> void:
	if id not in SaveLoad.save_file.opened_chests:
		$AnimationPlayer.play("open")
		SaveLoad.save_file.insert(item)
		$AnimatedSprite2D.animation = "opened"
		SaveLoad.save_file.opened_chests.append(id)
