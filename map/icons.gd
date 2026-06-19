extends TileMapLayer

@onready var player_map_pos = get_parent().get_node("Player_loc")
@onready var get_map_tiles = get_used_cells()
var map

var original_tiles = {} # cell coords -> [source_id, atlas_coords, alt_tile]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map = get_parent()
	
	var count = 0
	for tile in get_map_tiles:
		print(str(count)+": "+str(tile))
		original_tiles[tile] = [get_cell_source_id(tile), get_cell_atlas_coords(tile), get_cell_alternative_tile(tile)]
		count += 1
	update_discover()
	SaveLoad.save_file.connect("discover", update_discover)


func update_discover():
	for i in get_map_tiles.size():
		var cell = get_map_tiles[i]
		if i in SaveLoad.save_file.discovered_rooms:
			var data = original_tiles[cell]
			set_cell(cell, data[0], data[1], data[2])
		else:
			set_cell(cell, -1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
