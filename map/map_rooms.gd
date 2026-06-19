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
	update()
	update_discover()
	Globals.connect("pos_change",update)
	SaveLoad.save_file.connect("discover", update_discover)
	
	
func update():
	var tile_calc = map_to_local(get_map_tiles[Globals.current_room])
	var calc_tile = local_to_map(player_map_pos.position)
	player_map_pos.position = tile_calc
	map.scale = Vector2(2,2)
	map.position = get_viewport().get_visible_rect().size / 2 - tile_calc * 2

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
