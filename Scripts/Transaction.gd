extends Sprite

var id
var qty
var uid
var max_qty = 8

func init(id, qty, uid):
	self.id = id
	self.qty = qty
	self.uid = uid
	
	texture = load("res://Assets/Items/item" + str(id) + ".png")


func _process(delta):
	global_position = get_viewport().get_mouse_position()
	
	if qty > 1:
		$Number.text = str(qty)
		$Number.show()
	else:
		$Number.hide()