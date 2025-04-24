extends Control

var mouse_in_ui = false

var first_click = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ((mouse_in_ui and Input.is_action_just_released("use_tool")) or (Input.is_action_just_pressed("exit"))) and ($Menu.visible or !get_tree().root.get_child(0).get_paused()):
		#bring up menu, "pause game?"
		$Menu.visible = !$Menu.visible
		get_tree().call_group("Players", "_pause")
		
		if first_click:
			$Start.visible = false
			first_click = false


func _on_icon_mouse_entered() -> void:
	mouse_in_ui = true


func _on_icon_mouse_exited() -> void:
	mouse_in_ui = false
