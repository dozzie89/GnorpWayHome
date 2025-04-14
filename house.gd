extends Building

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = "Goopa"

func get_collider():
	return $CollisionShape2D


func interact(player):
	if player.health < player.max_health:
		player.health += 1
		print("healed one damage!")
