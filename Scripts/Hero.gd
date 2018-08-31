extends KinematicBody2D

var walk_speed = 150

var velocity = Vector2(0, 0)  # Vetor de velocidade

enum {UP, DOWN, LEFT, RIGHT}

var facing = DOWN #indica para que lado o personagem está olhando.

var switch_delta = Vector2(0, 0)

func _physics_process(delta):
	
	if switch_delta == Vector2(0, 0):
		var walk_left = Input.is_action_pressed("left")
		var walk_right = Input.is_action_pressed("right")
		var walk_up = Input.is_action_pressed("up")
		var walk_down = Input.is_action_pressed("down")
		
		velocity = Vector2()
		
		if walk_left and position.x > 19:
			velocity.x = -walk_speed
			facing = LEFT
		elif walk_right and position.x < 512:
			velocity.x = walk_speed
			facing = RIGHT
		elif walk_up and position.y > 10:
			velocity.y = -walk_speed
			facing = UP
		elif walk_down and position.y < 512:
			velocity.y = walk_speed
			facing = DOWN
	else:
		velocity = switch_delta * walk_speed
		## o walk speed é para caso o personagem esteja mudando de chunk, se ele tiver mudandod e chunk, não será possível controlar o movimento dele
		
	velocity = move_and_slide(velocity)
	set_anim()

func set_anim():
	if facing == RIGHT:
		$AnimMove.current_animation = "right_walk" if velocity.x != 0 else "right_stand"
		$Head.frame = 21
	elif facing == LEFT:
		$AnimMove.current_animation = "left_walk" if velocity.x != 0 else "left_stand"
		$Head.frame = 18
	elif facing == UP:
		$AnimMove.current_animation = "up_walk" if velocity.y != 0 else "up_stand"
		$Head.frame = 23
	elif facing == DOWN:
		$AnimMove.current_animation = "down_walk" if velocity.y != 0 else "down_stand"
		$Head.frame = 16
		
func anim_switch(from, to):
	switch_delta = to.index - from.index
	## se tiver na chunk 0x0 e quiser ir pra 1x0 (direita)
	## ele fará 1x0 - 0x0 que ficará 1x0, ou seja, ele irá para a direita 
	var global = global_position ## pega a posição global no momento atual
	
	from.remove_child(self) # remove o personagem da chunk atual
	to.add_child(self) # adiciona o personagem na nova chunk
	global_position = global # restaura a posição global
	
	$SwitchTimer.start()
	
	
func _on_SwitchTimer_timeout():
	switch_delta = Vector2(0, 0)
	get_parent().enter_chunk()