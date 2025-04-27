extends Control

var mouse_in_ui = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#TODO: update icon, etc.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ($Menu.visible and Input.is_action_just_released("exit")) or (mouse_in_ui and Input.is_action_just_released("use_tool") and ($Menu.visible or !get_tree().root.get_child(0).get_paused())):
		#bring up menu, "pause game?"
		$Menu.visible = !$Menu.visible
		var ow = get_tree().root.get_child(0)
		ow.set_paused(!ow.get_paused())


func _on_icon_mouse_entered() -> void:
	mouse_in_ui = true


func _on_icon_mouse_exited() -> void:
	mouse_in_ui = false


func change_visible(b):
	visible = b
