extends CanvasLayer

var Transaction = preload("res://Scenes/Transaction.tscn")

enum {IDLE, TRANS}
var state = IDLE

var cur_trans = null

func _ready():
	var trans = []
	
	var t1 = Transaction.instance()	
	t1.init(5, 45, null)
	trans.append(t1)
	
	var t2 = Transaction.instance()	
	t2.init(13, 1, 1)
	trans.append(t2)
	
	var t3 = Transaction.instance()	
	t3.init(20, 1, null)
	trans.append(t3)
	
	store(trans)
	
func store(trans):
	for slot in $Slots.get_children():
		if slot.store(trans): return

func is_idle():
	return state == IDLE

func is_trans():
	return state == TRANS

func set_trans(trans):
	if cur_trans != null:
		remove_child(cur_trans)
	cur_trans = trans
	add_child(cur_trans)
	state = TRANS

func set_idle():
	if cur_trans != null:
		remove_child(cur_trans)
		cur_trans = null
		
	state = IDLE