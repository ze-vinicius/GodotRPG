extends Control

var attack_force = 0
var helm_ratio = 1


func _on_SlotSword_changed():
	var id  = $SlotSword.id
	if id == null:
		attack_force = 0
	else:
		attack_force = Inventory.item_data[str(id)]["damage"]
	print("Ataque com ", attack_force)

func _on_SlotHelmet_changed():
	var id = $SlotHelmet.id
	if id == null:
		helm_ratio = 1
	else:
		helm_ratio = Inventory.item_data[str(id)]["defense"]
	print("Defesa de ", helm_ratio)