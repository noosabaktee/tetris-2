extends Node2D

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_node("Blocks/Block2").queue_free()
		get_node("Blocks/Block").active = true
