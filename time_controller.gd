extends Control

@export var cnst: float
var time_in_day = 60 * 24

@export var start_hr = 7

var current_time
var current_day

var last_update


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_time = start_hr * 60
	current_day = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not get_tree().root.get_child(0).get_paused():
		if current_time + cnst <= time_in_day:
			current_time += cnst
		else:
			current_time = 0
			current_day += 1
			get_tree().call_group("Daily", "reset")
	$Label.text = "Day: " + str(current_day) + "
					Time: " + int_to_time(int(current_time))
	
func int_to_time(num):
	var ret_str = ''
	ret_str += str(num / 60) + ":"
	if num % 60 < 10:
		ret_str += "0"
	ret_str += str(num % 60)
	return ret_str
