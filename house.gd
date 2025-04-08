extends Building


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_collider():
	return $CollisionShape2D


func interact(player):
	print('\"I\'m in a glass house digging up stones\" - joe p')
	player.kill()
