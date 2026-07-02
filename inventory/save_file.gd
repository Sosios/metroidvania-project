extends Resource

class_name Save

signal update
signal discover

@export var slots: Array[InvSlot]

@export var weapon: InvItem:
	set(value):
		weapon = value
		update.emit()
@export var armor: InvItem:
	set(value):
		armor = value
		update.emit()

@export_file("*.tscn") var current_room: String = "res://scenes/levels/zone_1.tscn"

@export var discovered_rooms := [0]
	
func discover_room(room: int):
	discovered_rooms.append(room)
	discover.emit()

@export var opened_chests := []

@export var opened_doors := []

@export var unlocked_doors := []

@export var defeated_bosses := []

@export var can_double_jump := false
@export var can_dash := false
@export var can_platform := false
@export var can_gravity := false

@export var attack := 10.0
@export var defense := 5.0

@export var player_selected := 0

@export var characters_unlocked := 0

@export var max_health := 100.0:
	set(value):
		max_health = value
		update.emit()
		
@export var exp_points := 0.0:
	set(value):
		exp_points = value
		if value >= nxtlvl:
			level += 1
			lvl_exp_cap = nxtlvl
			nxtlvl = (nxtlvl+100)*1.065
			attack = (attack+5)*1.02
			defense = (defense+5)*1.01
			Globals.health = Globals.health * (((max_health+20)*1.03)/max_health)
			max_health = (max_health+20)*1.03
		update.emit()
@export var nxtlvl := 100.0
var lvl_exp_cap = 0
@export var level := 1

var screen_color


func insert(item: InvItem):
	var item_slots = slots.filter(func(slot):return slot.item == item)
	if !item_slots.is_empty():
		item_slots[0].amount += 1
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
	update.emit()

func throw(item:InvItem):
	var item_slots = slots.filter(func(slot):return slot.item == item)
	if !item_slots.is_empty():
		item_slots[0].amount = max(0,item_slots[0].amount-1)
	update.emit()
