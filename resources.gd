extends RigidBody2D

class_name Resources

@export var health = 2
@export var resource_type = " "
@export var drops = {"unnamed resource": 0}

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	if $Sprite2D.visible == false and $HitParticles.emitting == false:
		queue_free()

func take_damage(amount): # Getting chopped down
	health -= amount
	
	$HitParticles.emitting = true
	
	if health <= 0:
		drop_resources()
		$Sprite2D.visible = false

func drop_resources():
	for resource_name in drops:
		get_tree().call_group("Inventory", "add_resources", resource_type, drops[resource_name])
