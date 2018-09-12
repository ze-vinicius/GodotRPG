extends CanvasLayer #Layer que sempre está sobreposto

var Transaction = preload("res://Scenes/Transaction.tscn")

enum {IDLE, TRANS} #IDLE= retira itens, TRANS = coloca itens
var state = IDLE

var cur_trans = null

var open = false

var item_data

func _ready():
	
	read_item_data()
	
	var trans = []
	
	var t1 = Transaction.instance()	
	t1.init(5, 16, null)
	trans.append(t1)
	
	var t2 = Transaction.instance()	
	t2.init(13, 4, 1)
	trans.append(t2)
	
	var t3 = Transaction.instance()	
	t3.init(20, 1, null)
	trans.append(t3)
	
	var t4 = Transaction.instance()
	t4.init(43, 1, null)
	trans.append(t4)
	
	store(trans)
	
func store(trans):
	#Função que tenta armazenar os itens nos slots disponíveis
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
	
func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_E:
			if open:
				close()
			else:
				open()

func close():
	$Anim.play_backwards("Open") 
	open = false
	if cur_trans != null:
		store([cur_trans])
		set_idle()
	
func open():
	$Anim.play("Open")
	open = true

func _on_BtnClose_pressed():
	close()

func read_item_data():
	var file = File.new()
	file.open("res://Assets/items.json", File.READ)
	
	item_data = parse_json(file.get_as_text())["items"]
	
func set_info(id):
	if id != null:
		$Back/Info.text = item_data[str(id)]["Info"]
	else:
		$Back/Info.text = " "