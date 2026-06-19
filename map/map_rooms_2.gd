extends TileMapLayer

@onready var player_map_pos = get_parent().get_node("Player_loc")
@onready var get_map_tiles = get_parent().get_child(1).get_used_cells()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	SaveLoad.save_file.connect("discover", update)

func update():
	for cell in get_map_tiles:
		for room in SaveLoad.save_file.discovered_rooms:
			if cell == get_map_tiles[room]:
				set_cell(cell,-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
