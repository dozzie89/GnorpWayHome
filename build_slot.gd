extends Panel

@export var id = 0
@export var unlocked = false
@export var build_name = 'none'
@export var building = Building
var placed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NameLabel.text = build_name
	if unlocked:
		modulate = Color(0, 255, 0)
	building = preload("res://house.tscn").instantiate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if unlocked:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
				print("left clicked on build slot")
				get_parent().get_parent().visible = false
				place_building()
				get_parent().get_parent().visible = true
				
func update_slot():
	$NameLabel.text = build_name
	if unlocked:
		modulate = Color(0, 255, 0)

func place_building():
	if placed:
		return
	building.position = get_viewport().get_mouse_position() + get_viewport().get_camera_2d().position - get_viewport_rect().size/2
	get_tree().root.add_child(building)
	placed = true
	#var mouse = get_viewport().get_mouse_position()
	
	#var v1 = mouse
	#var v2 = mouse
	
	#var space_state = get_world_2d().direct_space_state
	#var query = PhysicsRayQueryParameters2D.create(v1,v2)
	#var result = space_state.intersect_ray(query)
	
	#if result:
	#	print("Hit at point: ", result.position)
