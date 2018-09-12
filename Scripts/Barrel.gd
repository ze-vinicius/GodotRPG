extends StaticBody2D

export (Array) var ids

var destroyed = false

func damage(side, d):
	if destroyed:
		return
	destroyed = true
	$Sprite.frame = 1
	randomize()
	var index = randi() % ids.size()
	
	var id = ids[index]
	
	var t = preload("res://Scenes/Transaction.tscn").instance()
	t.init(id, 1, null)
	
	add_child(t)
	t.set_obj(global_position, get_node("/root/World").hero )