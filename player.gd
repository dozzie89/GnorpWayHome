extends Area2D

@export var gnorp_name = 'none'

@export var id = 0

var health
@export var max_health = 3
@export var speed = 400

@export var sprint_speed = 1.75

@export var hit_distance = 200

@export var active_player = false

#temp
@export var color = Color(0,0,0)

var in_area = false
var last_area = null

var can_use = true

var screen_size

signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	
	$ProgressBar.max_value = max_health
	$ProgressBar.value = health
	
	$CollisionShape2D.disabled = false
	
	screen_size = get_viewport_rect().size
	
	$BodySprite.animation = "idle"
	$FaceSprite.animation = "idle"
	$BodySprite.play()
	$FaceSprite.play()
	
	$BodySprite.modulate = color
	
	$ActiveIndicator.visible = active_player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().root.get_child(0).get_paused() or not active_player:
		return
		
	var diag = false
	
	#movement
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		diag = true
		$BodySprite.animation = "move_right"
		$FaceSprite.animation = "move_right"
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		diag = true
		$BodySprite.animation = "move_left"
		$FaceSprite.animation = "move_left"
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		if not diag:
			$BodySprite.animation = "move_down"
			$FaceSprite.animation = "move_down"
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		if not diag:
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
	#position = position.clamp(Vector2.ZERO, screen_size)
	
	
	#weapon use
	if Input.is_action_pressed("use_tool") and can_use:
		
		$Tool.swing_animation()
		
		var target = Vector2(get_viewport().get_mouse_position() + get_viewport().get_camera_2d().position - get_viewport_rect().size/2)
		var vec = target - position
		vec = hit_distance * vec / vec.length()
		
		$Hitbox.target_position = vec
		#animation
		can_use = false
		$CooldownTimer.start()
		$Hitbox.force_raycast_update()
		if $Hitbox.is_colliding():
			var object = $Hitbox.get_collider()
			if object.is_in_group("Enemies"):
				object.take_damage($Tool.damage)
			elif object.is_in_group("Resources"):
				object.take_damage($Tool.damage)
				
	if Input.is_action_just_pressed("interact"):
		if last_area != null:
			last_area.interact(self)
		pass
		
func _on_cooldown_timer_timeout() -> void:
	can_use = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Tools") and not area.equippable:
		return
	in_area = true
	last_area = area
	
	if area.is_in_group("Enemies"):
		hit.emit(area.damage)
	if area.is_in_group("Tools"):
		area.show_menu(true)

func _on_area_exited(area: Area2D) -> void:
	if last_area == area:
		in_area = false
		last_area = null
		if area.is_in_group("Tools"):
			area.show_menu(false)


func _on_hit(damage) -> void:
	health -= damage
	$ProgressBar.value = health
	if health <= 0:
		kill()
	
func _pause() -> void:
	var ow = get_tree().root.get_child(0)
	ow.set_paused(!ow.get_paused())

func get_tool():
	return $Tool
	
func set_tool(tool):
	$Tool/TextureRect.texture = tool.get_texture()
	$Tool.damage = tool.damage

func set_player(player):
	#todo: update all of these with new info
	#todo: need different sprites? maybe not
	health = player.health
	speed = player.speed
	sprint_speed = player.sprint_speed
	hit_distance = player.hit_distance
	color = player.color
	set_tool(player.get_tool())
	
	$BodySprite.modulate = color
	
	in_area = false
	last_area = null

func generate_icon():
	var icon = TextureRect.new()
	icon.add_child($BodySprite)
	icon.add_child($FaceSprite)
	return icon

func set_active(s_id):
	if s_id == id:
		active_player = true
		get_tree().call_group("Camera", "update_player", self)
		get_tree().call_group("Slot", "update_slot", get_tool())
	else:
		active_player = false
	$ActiveIndicator.visible = active_player

func interact(_player):
	pass

func get_timer():
	return $CooldownTimer

func kill():
	get_tree().call_group("Controller", 'player_removed', id)
	queue_free()
