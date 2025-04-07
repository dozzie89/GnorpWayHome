extends Panel

@export var id = 0
@export var unlocked = false
@export var build_name = 'none'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NameLabel.text = build_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if unlocked:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
				print("left clicked on build slot")
				#TODO
		
func update_slot():
	$NameLabel.text = build_name
