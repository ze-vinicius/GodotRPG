extends Camera2D

func anim_switch(delta):
	limit_left += delta.x * 512
	limit_right = limit_left + 512
	limit_top += delta.y * 512
	limit_bottom = limit_top + 512