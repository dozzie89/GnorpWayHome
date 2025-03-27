extends Label

#Spriggi
@export var wood = 0

#Plimbloo
@export var ore = 0

#Goopa
@export var slime = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_resources(r_name, r_num):
	var resource = null
	print(r_name)
	match r_name:
		"Spriggi":
			wood += r_num
		"Plimbloo":
			ore += r_num
		"Goopa":
			slime += r_num
		_:
			print("error with resource - invalid name")
	update_label()

func update_label():
	text = "Spriggi: " + str(wood) + '\n'
	text += "Plimbloo: " + str(ore) + '\n'
	text += "Goopa: " + str(slime) + '\n'
