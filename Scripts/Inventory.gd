extends CanvasLayer

func store(trans):
	for slot in $Slots.get_children():
		if slot.store(trans): return
		else:
			
			