extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Click on a topic to learn more!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update(inf_text):
	text = inf_text
