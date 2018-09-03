extends Panel

var Transaction = preload("res://Scenes/Transaction.tscn") # pre-carrega a cena Transaction

var id = null
var qty = 0
var uid = null

func store(trans):
	
	var all_done = true
	
	var i = 0 #quantidade de itens na transaction
	
	while i != trans.size():
		var t = trans[i] # pega o item do vetor
		if id != null and id != t.id or uid != null and uid != t.uid:
			"""Se o id for diferente de nulo, significa que há itens no slot
			e se o id for diferente do id da transação, significa que são itens diferentes
			e por isso, não dá para armazenar.
			Se o uid (id unico) for diferente também do uid da transação,
			também será impossível armazenar. (há itens como chaves que 
			possuem id igual (são todas chaves) mas servem para portas diferentes,
			ou seja, não se pode misturá-las"""
			i += 1 #por isso ele aumenta o contador e volta pro inicio do while
			all_done = false # variável para verificação da tentativa de armazenamento
			continue
		"""Se passar pelo 'if' acima, siginifca que o slot
		está vazio, ou que os itens são iguais. Portanto,
		o id e o uid recebem o id da transação"""
		
		id = t.id 
		uid = t.uid
		
		if qty + t.qty > t.max_qty:
			"""Realiza a verificação da quantidade de item
			presente no slot e do item que será armazenado
			em relação a quantidade máxima que cada item pode
			ser armazenado no mesmo slot"""
			t.qty -= (t.max_qty - qty)
			"""Sendo a soma maior que a qty max, transefere-se
			o máximo possível do item para o slot e permanece
			com o que sobrar"""
			qty = t.max_qty
			all_done = false
			break #Se atingiu a quantidade máxima, não faz sentido continuar no loop
		
		else:
			"""Caso a quantidade seja menor que a máxima
			apenas soma as quantidades no slot e 
			remove a (cena) transação"""
			qty += t.qty
			trans.remove(i)
	
	update_info() #Atualiza as informações de número e textura dos slots
	
	return all_done


func update_info():
	"""Se não tem id (null), a textura permanece nula,
	já que significa que o slot está vazio"""
	if id == null:
		$Image.texture = null 
	else:
		$Image.texture = load("res://Assets/Items/item" + str(id) + ".png")
	
	if qty > 1:
		$Number.text = str(qty)
		$Number.show()
	else:
		$Number.hide()

func _input(event):
	"""Está função serve para pegar o evento de click do mouse"""
	if event is InputEventMouseButton and event.pressed and post_inside(event.position):
		"""Verifica se o evento é um click do mouse e se ele está apenas clicando e
		também se está clicando dentro do espaço do slot"""
		if Inventory.is_idle():
			# retirar itens
			if id == null: return 
			#Se o id é null, ou seja se o slot está vazio
			#Nada acontece
			
			var new_trans = Transaction.instance()
			if event.button_index == 1:
				"""Se for um clic com o botão esquerdo
				inicia uma nova transacao com todas as especificações
				do item presente no slot e esvazia o slot atual"""
				new_trans.init(id, qty, uid)
				id = null
				qty = 0
				uid = null
			
			else:
				"""Se for o botão direito, 
				pega metade dos itens e deixa o resto no slot"""
				if qty == 1:
					return
				new_trans.init(id, qty/2, uid) # caso tenha números ímpares
				qty -= qty/2
			
			Inventory.set_trans(new_trans)
			
			update_info() # atualiza as informações, ou seja, se tiver item e clicar, ele vai sumir
		elif Inventory.is_trans():
			"""Se já há uma transação ocorrendo"""
			if event.button_index == 1:
				
				if id != null and Inventory.cur_trans.id != id:
					var new_trans = Transaction.instance()
					new_trans.init(id, qty, uid)
					
					id = null
					qty = 0
					uid = null
					
					store([Inventory.cur_trans])
					Inventory.set_trans(new_trans)
				
				else:
					if store([Inventory.cur_trans]):
						Inventory.set_idle()
					
			else:
				var cur_trans = Inventory.cur_trans
				
				if cur_trans.qty > 1:
					var new_trans = Transaction.instance()
					new_trans.init(cur_trans.id, 1, cur_trans.uid)
					
					if store([new_trans]):
						cur_trans.qty -= 1
						
func post_inside(pos):
	return get_global_rect().has_point(pos)