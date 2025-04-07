extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_player(id):
	if id == 1:
		return $Player
	if id == 2:
		return $Player2
	if id == 3:
		return $Player3
	return null

func add_player(g_name):
	return
