extends RigidBody2D

@export var health = 2
@export var speed = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BodySprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_damage(damage):
	print("damage: " + str(damage))
	print("old health: " + str(health))
	
	health = health - damage
	
	print("new health: " + str(health))
	
	if health <= 0:
		#do stuff!
		queue_free()
