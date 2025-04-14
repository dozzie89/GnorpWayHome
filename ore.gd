extends Resources

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 1
	resource_type = "Plimbloo"
	drops = {"stone": 3}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
