extends Area2D

class_name Building

var resource = ''
var num = 3

var usable = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func reset():
	usable = true
	modulate = Color(1, 1, 1)
