extends Node2D

onready var cur_chunk = get_node("Chunk0x0")
onready var hero = cur_chunk.get_node("Hero")

var cur_world = "World"
var from_chunk = null
var to_chunk = null

var switching = false


func switch_chunk(from_chunk, delta):
	
	if switching: return
	
	switching = true
	
	self.from_chunk = from_chunk
	var to_index = from_chunk.index + delta
	
	var ckstr = cur_world + "_"  + str(to_index.x) + "x" + str(to_index.y)
	
	var pre_chunk = load("res://Scenes/Chunks/" + cur_world + "/" + ckstr + ".tscn")
	
	to_chunk = pre_chunk.instance()
	add_child(to_chunk)
	
	hero.anim_switch(from_chunk, to_chunk)
	
	hero.get_node("Camera").anim_switch(delta)
	
	from_chunk.queue_free()

func finish_switch():
	switching = false