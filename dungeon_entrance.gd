extends Area2D

@export var teleport_location = Area2D

@export var does_generate = false

@export var spawn1 = Vector2()
@export var spawn2 = Vector2()
@export var spawn3 = Vector2()

var en_scene = preload("res://enemy.tscn")
var tl_scene = preload("res://tool.tscn")

var spawns = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn1 += teleport_location.position
	spawn2 += teleport_location.position
	spawn3 += teleport_location.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func interact(player) -> void:
	player.position = teleport_location.position
	if does_generate:
		generate()

func generate():
	print("GENERATING")
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
		
	add_child(enemy1)
	add_child(enemy2)
	add_child(tool)
	
	spawns.append(enemy1)
	spawns.append(enemy2)
	spawns.append(tool)
	
	for spawn in spawns:
		print("GENERATED NEW SPAWN ", spawn)
	
func clear():
	print("CLEARING EXISTING SPAWNS")
	for spawn in spawns:
		print("CLEARED SPAWN ", spawn)
		spawn.queue_free()
