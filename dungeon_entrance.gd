extends Area2D

@export var in_dungeon = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact(player) -> void:
	print("here")
	#player.position = Vector2(0, 0)
	if(in_dungeon):
		get_tree().change_scene_to_file("res://overworld.tscn")
	else:
		get_tree().change_scene_to_file("res://dungeon.tscn")
		add_child(player)
		print(get_tree())
		print(player)
