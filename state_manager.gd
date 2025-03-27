extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func save_player(player):
	var save_file = FileAccess.open("user://player.save", FileAccess.WRITE)
	var node_data = player.call("save")
	var json_string = JSON.stringify(node_data)
	save_file.store_line(json_string)

func load_player():
	if not FileAccess.file_exists("user://player.save"):
		print("error loading player - no player file")
		return
	
	var save_file = FileAccess.open("user://player.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.data
		print("load successful! player: " + str(node_data))


func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")

	for node in save_nodes:
		
		#maybe don't need this?
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
			
		var node_data = node.call("save")
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)

	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("error loading game - no save file")
		return # Error! We don't have a save to load.

	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.data
		print("load successful! data: " + str(node_data))
