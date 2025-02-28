extends Area2D

@export var health = 3
@export var speed = 400

@export var sprint_speed = 1.75

@export var hit_distance = 150

signal hit

var can_use = true

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape2D.disabled = false
	
	screen_size = get_viewport_rect().size
	$BodySprite.play()
	$FaceSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#movement
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		$BodySprite.animation = "move_right"
		$FaceSprite.animation = "move_right"
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		$BodySprite.animation = "move_left"
		$FaceSprite.animation = "move_left"
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		$BodySprite.animation = "move_down"
		$FaceSprite.animation = "move_down"
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		$BodySprite.animation = "move_up"
		$FaceSprite.animation = "move_up"
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if Input.is_action_pressed("sprint"):
			velocity *= sprint_speed
	else:
		$BodySprite.animation = "idle"
		$FaceSprite.animation = "idle"
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	
	#weapon use
	if Input.is_action_pressed("use_tool") and can_use:
		
		var target = Vector2(get_viewport().get_mouse_position())
		var vec = target - position
		vec = hit_distance * vec / vec.length()
		
		$Hitbox.target_position = vec
		#animation
		can_use = false
		$CooldownTimer.start()
		if $Hitbox.is_colliding():
			var object = $Hitbox.get_collider()
			if object.is_in_group("Enemies"):
				print("enemy detected!")
				object.take_damage($Tool.damage)
				
	if Input.is_action_just_pressed("interact"):
		#TODO - if colliding with tool, swap them
		pass


func _on_cooldown_timer_timeout() -> void:
	can_use = true


func _on_body_entered() -> void:
	hit.emit()
	print("HERE!")
	queue_free()
