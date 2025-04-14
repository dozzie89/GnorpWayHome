extends Building


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = "Spriggi"

func get_collider():
	return $CollisionShape2D

func interact(_player):
	get_tree().call_group("Inventory", "add_resources", "Spriggi", 1)
