extends Area2D

export (String) var to_world
export (Vector2) var to_index
export (int) var to_door

export (Vector2) var out_dir

func _on_Door_body_entered(body):
	get_node("/root/World").switch_world(get_parent(), to_world, to_index, to_door)