extends Panel

@export var id = 0
@export var unlocked = false
@export var build_name = 'none'
@export var building = Building
var placed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NameLabel.text = build_name
	if unlocked and not placed:
		modulate = Color(0, 255, 0)
	else:
		modulate = Color(1, 1, 1)
	match id:
		1:
			building = preload("res://house.tscn").instantiate()
		2:
			building = preload("res://woodcutter.tscn").instantiate()
		3:
			building = preload("res://stonecutter.tscn").instantiate()
		_:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if unlocked:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
				get_parent().get_parent().visible = false
				get_parent().get_parent().get_parent().get_node("Button").visible = true
				get_parent().get_parent().get_parent().get_node("Label").visible = true
				await place_building()
				get_parent().get_parent().visible = true
				get_parent().get_parent().get_parent().get_node("Button").visible = false
				get_parent().get_parent().get_parent().get_node("Label").visible = false
				
func update_slot():
	$NameLabel.text = build_name
	if unlocked and not placed:
		modulate = Color(0, 255, 0)
	else:
		modulate = Color(1, 1, 1)

func place_building():
	var result = [true]
	
	while result:
		if placed:
			return
		await get_parent().get_parent().get_parent().get_node("Button").button_up
		var mouse = get_viewport().get_mouse_position() + get_viewport().get_camera_2d().position - get_viewport_rect().size/2
		building.position = mouse
				
		var bounds = building.get_collider().shape.extents
		
		var v1 = mouse - bounds/2
		var v2 = mouse + bounds/2
		
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(v1,v2)
		query.set_collide_with_areas(true)
		query.set_hit_from_inside(true)
		result = space_state.intersect_ray(query)
		
		if result:
			get_parent().get_parent().get_parent().get_node("Label").text = "Can't place on top of " + str(result['collider'].name)
		else:
			get_tree().call_group("Overworld", "add_building", building)
			placed = true
			update_slot()
			
			#get_tree().call_group("Inventory", "add_resources", building.resource, -building.num)
			break
