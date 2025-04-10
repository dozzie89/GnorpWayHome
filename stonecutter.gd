extends Building


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = "Plimbloo"

func get_collider():
	return $CollisionShape2D

func interact(player):
	get_tree().call_group("Inventory", "add_resources", "Plimbloo", 1)
