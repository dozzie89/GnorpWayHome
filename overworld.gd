extends Node

@export var paused = false

var rng

var left_bound = -700
var up_bound = -200
var right_bound = 2200
var down_bound = 1600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()

func get_player(id):
	if id == 1:
		return $Player
	if id == 2:
		return $Player2
	if id == 3:
		return $Player3
	return null

func add_building(building):
	$Buildings.add_child(building)

func get_paused():
	return paused
	
func set_paused(p):
	paused = p

func lose():
	$UI/LoseText.visible = true
	
	paused = true
	
	var tween = get_tree().create_tween()
	tween.tween_interval(3)
	tween.tween_callback(restart_game)
	
func restart_game():
	get_tree().change_scene_to_file("res://title.tscn")


#generate resources on daily reset
func reset():
	for i in range(rng.randi_range(8, 16)):
		var x = rng.randi_range(left_bound, right_bound)
		var y = rng.randi_range(up_bound, down_bound)
		
		var new_resource = null
		
		if rng.randi_range(0, 1):
			new_resource = preload("res://tree.tscn").instantiate()
		else:
			new_resource = preload("res://ore.tscn").instantiate()
			
		new_resource.position = Vector2(x, y)
					
		$ResourceCollect.add_child(new_resource)
