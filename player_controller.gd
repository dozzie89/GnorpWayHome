extends Control

var mouse_in_ui = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Icon/BodySprite.animation = "idle"
	$Icon/FaceSprite.animation = "idle"
	$Icon/BodySprite.play()
	$Icon/FaceSprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ($Menu.visible and Input.is_action_just_released("exit")) or (mouse_in_ui and Input.is_action_just_released("use_tool") and ($Menu.visible or !get_tree().root.get_child(0).get_paused())):
		#bring up menu, "pause game?"
		$Menu.visible = !$Menu.visible
		get_tree().call_group("Players", "_pause")


func _on_icon_mouse_entered() -> void:
	mouse_in_ui = true


func _on_icon_mouse_exited() -> void:
	mouse_in_ui = false
