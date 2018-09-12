extends Node2D

onready var cur_chunk = get_node("Chunk0x0") #Pega a chunk 0x0 como chunk atual
onready var hero = cur_chunk.get_node("Hero") 

var cur_world = "World" #Esse é o mundo atual (Ex: world, house, dungeon)
var from_chunk = null
var to_chunk = null

var switching = false 
#Variável de troca, verifica se o personagem 
#já está trocando de chunk


func switch_chunk(from_chunk, delta):
	
	if switching: return 
	#Se estiver já estiver trocando, sai da função.
	#Isso evita que o personagem fique num loop de troca de chunk
	
	switching = true 
	#Na entrada da função, já troca o status para verdadeiro
	
	self.from_chunk = from_chunk 
	#Pega a chunk de onde o personagem está saindo
	var to_index = from_chunk.index + delta
	#Seta o index da chunk que o personagem irá
	
	var ckstr = cur_world + "_"  + str(to_index.x) + "x" + str(to_index.y)
	#Seta como string o path da próxima chunk
	
	var pre_chunk = load("res://Scenes/Chunks/" + cur_world + "/" + ckstr + ".tscn")
	#Carrega a próxima chunk
	
	to_chunk = pre_chunk.instance()
	#Instancia a chunk
	
	add_child(to_chunk)
	#Seta como filho do "World"
	
	hero.anim_switch(from_chunk, to_chunk)
	#Chama a função que move o personagem para a próxima chunk
	hero.get_node("Camera").anim_switch(delta)
	#Chama a função que altera o limite das câmeras.
	from_chunk.queue_free()
	#Remove a chunk como filho
	
func finish_switch():
	switching = false
	
func switch_world(from_chunk, to_world, to_index, to_door):
	if switching:
		return
	switching = true
	
	cur_world = to_world
	self.from_chunk = from_chunk
	
	var ckstr = cur_world + "_"  + str(to_index.x) + "x" + str(to_index.y)
	#Seta como string o path da próxima chunk
	
	var pre_chunk = load("res://Scenes/Chunks/" + cur_world + "/" + ckstr + ".tscn")
	#Carrega a próxima chunk
	
	to_chunk = pre_chunk.instance()
	add_child(to_chunk)
	
	var door = to_chunk.get_node("Door" + str(to_door))
	
	hero.pass_door(from_chunk, to_chunk, door)
	
	var camera = hero.get_node("Camera")
	
	camera.anim_switch(to_chunk.index - from_chunk.index)
	
	from_chunk.queue_free()





	