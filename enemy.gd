extends Area2D

@export var health = 2
@export var speed = 200

@export var damage = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BodySprite.play()
	
	$ProgressBar.max_value = health
	$ProgressBar.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $BodySprite.visible == false and $Audio.playing == false:
		queue_free()



func take_damage(in_damage):
	health = health - in_damage
	$ProgressBar.value = health
	
	$Audio.play()
		
	if health <= 0:
		#do stuff!
		get_tree().call_group("Inventory", "add_resources", "Goopa", 2)
		$BodySprite.visible = false
		$CollisionShape2D.disabled = true
		$ProgressBar.visible = false


func interact(_player):
	pass
