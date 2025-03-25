extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(get_node_or_null("Player")):
		# $Slot.scale.x = ($Player/CooldownTimer.wait_time - $Player/CooldownTimer.time_left) / 2 * $Player/CooldownTimer.wait_time
		$Slot.scale.y = ($Player/CooldownTimer.wait_time - $Player/CooldownTimer.time_left) / 2 * $Player/CooldownTimer.wait_time

func get_player(id):
	if id == 1:
		return $Player
	if id == 2:
		return $Player2
	if id == 3:
		return $Player3
	return null
