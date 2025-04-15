extends Building


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = "Plimbloo"
	
func _process(_delta: float) -> void:
	pass

func get_collider():
	return $CollisionShape2D

func interact(_player):
	if not usable: 
		return
	get_tree().call_group("Inventory", "add_resources", "Plimbloo", 1)
	usable = false
	modulate = Color(1, 0, 0)
