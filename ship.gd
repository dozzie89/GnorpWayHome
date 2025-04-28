extends Area2D

var default_text = "Repair the ship with:
					175 Spriggi
					150 Plimbloo
					15 Goopa"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = default_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func show_menu(b):
	if b:
		$Label.visible = true
	else:
		$Label.visible = false

func interact(_player):
	get_tree().call_group("Inventory", "check_win")
	#if resources greater than limits, you win!
	if is_instance_valid(get_tree()):
		$Label.text = "You don't have enough resources!"
		var tween = get_tree().create_tween()
		tween.tween_interval(2)
		tween.tween_callback(reset_label)
	
func reset_label():
	$Label.text = default_text
