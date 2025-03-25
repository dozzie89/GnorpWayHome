extends RigidBody2D

class_name Resources

@export var health = 2
@export var resource_type = " "
@export var drops = {"unnamed resource": 0}

func _ready():
	pass

func take_damage(amount): # Getting chopped down
	health -= amount
	
	if health <= 0:
		drop_resources()
		queue_free()

func drop_resources():
	for resource_type in drops:
		print("Dropping " + str(drops[resource_type]) + " " + resource_type)
