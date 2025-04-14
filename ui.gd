extends Node

@export var player = Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_instance_valid(player):
		self.position = player.position
		
		var timer = player.get_timer()
		$Slot.scale.y = (timer.wait_time - timer.time_left) / 2 * timer.wait_time

func update_player(tplay):
	player = tplay
