extends Control

#add signal when active player is switched

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_slot(tool):
	$Tool/TextureRect.texture = tool.get_texture()

func _on_mouse_entered() -> void:
	$Tool.show_menu(true)


func _on_mouse_exited() -> void:
	$Tool.show_menu(false)
