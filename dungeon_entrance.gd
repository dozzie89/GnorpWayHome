extends Area2D

@export var teleport_location = Area2D

@export var does_generate = false

@export var spawn1 = Vector2()
@export var spawn2 = Vector2()
@export var spawn3 = Vector2()

var usable = true

var en_scene = preload("res://enemy.tscn")
var tl_scene = preload("res://tool.tscn")

var spawns = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if does_generate:
		spawn1 += teleport_location.position
		spawn2 += teleport_location.position
		spawn3 += teleport_location.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func interact(player) -> void:
	if not usable:
		return
	player.position = teleport_location.position
	if does_generate:
		usable = false
		modulate = Color(1, 0, 0)
	
		generate()
		get_tree().call_group("OverworldOnly", "change_visible", false)
	else:
		get_tree().call_group("OverworldOnly", "change_visible", true)

func generate():
	clear()
	var rng = RandomNumberGenerator.new()
	
	var enemy1 = en_scene.instantiate()
	enemy1.position = spawn1
	var enemy2 = en_scene.instantiate()
	enemy2.position = spawn2
	var tool = tl_scene.instantiate()
	tool.position = spawn3
	tool.equippable = true
	tool.damage = rng.randi_range(1,4)
	if rng.randi_range(0,1) == 1:
		tool.texture = "res://art/character-sprites/sword.png"
		tool.damage = rng.randi_range(2,8)
		
	get_tree().root.get_child(0).get_node("DungeonCollect").add_child(enemy1)
	get_tree().root.get_child(0).get_node("DungeonCollect").add_child(enemy2)
	get_tree().root.get_child(0).get_node("DungeonCollect").add_child(tool)
		
	#get_tree().root.get_child(0).add_child(enemy1)
	#get_tree().root.get_child(0).add_child(enemy2)
	#get_tree().root.get_child(0).add_child(tool)
	
	spawns.append(enemy1)
	spawns.append(enemy2)
	spawns.append(tool)
	
func clear():
	for spawn in spawns:
		if is_instance_valid(spawn):
			spawn.queue_free()
	spawns = []

func reset():
	usable = true
	modulate = Color(1, 1, 1)
