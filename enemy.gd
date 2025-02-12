extends Area2D

@export var health = 1
@export var speed = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BodySprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
