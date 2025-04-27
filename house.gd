extends Building

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = "Goopa"

func get_collider():
	return $CollisionShape2D


func interact(player):
	if not usable: 
		return
	if player.health < player.max_health:
		player.health += 1
		player.get_node("ProgressBar").value = player.health
		usable = false
		modulate = Color(1, 0, 0)
