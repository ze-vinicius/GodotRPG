extends YSort 
# classe que muda a disposição dos itens de acordo com seu eixo y
#
export (Vector2)  var index
# Exporta os indices das chunks de acordo com o "mundo"

func _ready():
	position = index * 512
	#dispõe as telas de acordo com seus índices

func exit_chunk(delta):
	get_parent().switch_chunk(self, delta)
	#Função de saída da chunk atual
	
func enter_chunk():
	get_parent().finish_switch()
	#Função de entrada na chunk