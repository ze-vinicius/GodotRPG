extends Node2D

func show_item(trans):
	$Sprite.texture = load("res://Assets/Items/item" + str(trans.id) + ".png")
	$Anim.play("Show")
	yield($Anim, "animation_finished")
	Inventory.store([trans])