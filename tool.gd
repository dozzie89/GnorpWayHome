extends Node2D

@export var damage = 1

@export var texture = "res://art/test sprites/pickaxe.png"

@export var equippable = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = load(texture)

func interact(player) -> void:
	if not equippable:
		return
	var temp_tool = player.get_tool()
	var temp_texture = temp_tool.get_texture()
	var temp_damage = temp_tool.damage

	player.set_tool(self)
	set_tool(temp_texture, temp_damage)
	
func get_texture():
	return $TextureRect.texture
	
func set_tool(ttexture, tdamage):
	$TextureRect.texture = ttexture
	damage = tdamage
