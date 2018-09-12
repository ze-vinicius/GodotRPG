extends StaticBody2D

export (int) var id
export (int) var qty
export (int) var uid

var used = false
var one_use = true

func _on_ActiveArea_body_entered(body):
	if used and one_use:
		return
	if body.has_method("activate"):
		body.activate(self)


func _on_ActiveArea_body_exited(body):
	if body.has_method("deactivate"):
		body.deactivate(self)

func use():
	if used: return
	used = true
	$Sprite.playing = true
	var t = preload("res://Scenes/Transaction.tscn").instance()
	t.init(id, qty, uid)
	
	HUD.get_node("NewItem").show_item(t)