extends Node2D

@export var damage = 1

@export var texture = "res://art/character-sprites/pickaxe.png"

@export var equippable = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = load(texture)
	$CollisionShape2D.disabled = not equippable
	
	$Label.text = "damage: " + str(damage)
	
func _process(_delta: float) -> void:
	pass
	
func swing_animation():
	look_at(Vector2(get_viewport().get_mouse_position() + get_viewport().get_camera_2d().position - get_viewport_rect().size/2))
	$AnimationPlayer.play("swing")

func interact(player) -> void:
	if not equippable:
		return
	var temp_tool = player.get_tool()
	var temp_texture = temp_tool.get_texture()
	var temp_damage = temp_tool.damage
	
	show_menu(false)
	
	equippable = false

	player.set_tool(self)
	set_tool(temp_texture, temp_damage)
	
	equippable = true

	get_tree().call_group("Slot", "update_slot", player.get_tool())
	
func get_texture():
	return $TextureRect.texture
	
func get_damage():
	return damage
	
func set_tool(ttexture, tdamage):
	$TextureRect.texture = ttexture
	damage = tdamage

func show_menu(b):
	if b:
		$Label.text = "damage: " + str(damage)
		$Label.visible = true
	else:
		$Label.visible = false
