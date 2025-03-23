extends Panel

@export var id = 0
@export var has_player = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$IdLabel.text = str(id)
	$HasPlayerLabel.text = str(has_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if has_player:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
				print("left clicked on player slot")
				get_tree().call_group("Players", "set_active", id)
