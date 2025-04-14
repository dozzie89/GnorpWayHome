extends Panel

@export var id = 0
@export var has_player = false
@export var gnorp_name = 'none'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$IdLabel.text = str(id)
	if has_player:
		modulate = Color(0,1,0)
	else:
		modulate = Color(1,0,0)
	$NameLabel.text = gnorp_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if has_player:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
				print("left clicked on player slot")
				get_tree().call_group("Players", "set_active", id)

func player_removed(g_id):
	if g_id == id:
		id = 0
		has_player = false
		gnorp_name = 'none'
		update_slot()
		
func update_slot():
	$IdLabel.text = str(id)
	if has_player:
		modulate = Color(0,1,0)
	else:
		modulate = Color(1,0,0)
	$NameLabel.text = gnorp_name

func player_added(g_id, g_name):
	if g_id == id:
		if has_player == true:
			return false
		has_player = true
		gnorp_name = g_name
		update_slot()
