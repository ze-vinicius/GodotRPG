extends Camera2D

func anim_switch(delta):
	"""
		função da câmera, a parte de visualização do jogador.
		calcula os limites da tela (até onde a câmera vai,
		ou seja, o limite da chunk)
	"""
	
	limit_left += delta.x * 512
	limit_right = limit_left + 512
	limit_top += delta.y * 512
	limit_bottom = limit_top + 512