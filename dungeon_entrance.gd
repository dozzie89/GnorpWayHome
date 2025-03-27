extends Area2D

@export var in_dungeon = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact(player) -> void:
	print("oh boy")
	for node in get_tree().current_scene.get_children():
		print(node)
	
	print("interacting with dungeon")
	if(in_dungeon):		
		get_tree().change_scene_to_file("res://overworld.tscn")

		#todo: update player after leaving dungeon
		#new tool, health, etcs
	else:
		#get_tree().call_group("StateManager", "save_game")
		#get_tree().call_group("StateManager", "save_player", player)
		get_tree().current_scene.queue_free()
		
		var dungeon = preload("res://dungeon.tscn")
		var dungeon_scene := dungeon.instantiate()
		
		get_tree().root.add_child(dungeon_scene)
		get_tree().current_scene = dungeon_scene
		
		get_tree().current_scene.get_player().set_player(player)
