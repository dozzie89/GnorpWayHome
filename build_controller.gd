extends Control

var mouse_in_ui = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#TODO: update icon, etc.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_in_ui and Input.is_action_just_released("use_tool"):
		#bring up menu, "pause game?"
		$Menu.visible = !$Menu.visible
		get_tree().call_group("Players", "_pause")


func _on_icon_mouse_entered() -> void:
	print("mouse entering ui icon")
	mouse_in_ui = true


func _on_icon_mouse_exited() -> void:
	print("mouse leaving ui icon")
	mouse_in_ui = false
