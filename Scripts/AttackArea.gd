extends Node2D

func attack(side, d):
	if Inventory.open:
		return
		
	var bodies
	
	if side == get_parent().LEFT:
		bodies = $Left.get_overlapping_bodies()
	elif side == get_parent().RIGHT:
		bodies = $Right.get_overlapping_bodies()
	elif side == get_parent().DOWN:
		bodies = $Down.get_overlapping_bodies()
	elif side == get_parent().UP:
		bodies = $Up.get_overlapping_bodies()
		
	for bodie in bodies:
		if bodie.has_method("damage") and bodie != get_parent():
			bodie.damage(side, d)
	
	if d == 0:
		return
	$Sword.frame = 0
	
	if side == get_parent().LEFT:
		$Sword.play("Left")
	elif side == get_parent().RIGHT:
		$Sword.play("Right")
	elif side == get_parent().DOWN:
		$Sword.play("Down")
	elif side == get_parent().UP:
		$Sword.play("Up")