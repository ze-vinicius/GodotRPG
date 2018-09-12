extends KinematicBody2D

var walk_speed = 150

var velocity = Vector2(0, 0)

func _physics_process(delta):
	
	if velocity == Vector2(0, 0):
		$AnimHero.stop()
		$AnimHero.set_frame(0)
		
	var walk_left = Input.is_action_pressed("left")
	var walk_right = Input.is_action_pressed("right")
	var walk_down = Input.is_action_pressed("down")
	var walk_up = Input.is_action_pressed("up")
	
	velocity = Vector2()
	
	if walk_left:
		velocity.x = -walk_speed
		$AnimHero.set_animation("move_left")
	elif walk_right:
		velocity.x = walk_speed
		$AnimHero.set_animation("move_right")
	elif walk_up:
		velocity.y = -walk_speed
		$AnimHero.set_animation("move_up")
	elif walk_down:
		velocity.y = walk_speed
		$AnimHero.set_animation("move_down")
	
	velocity = move_and_slide(velocity)
	
	if not $AnimHero.is_playing():
		$AnimHero.play()
