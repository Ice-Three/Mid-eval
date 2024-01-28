extends CharacterBody2D

@export var speed = 500
@export var gravity = 30
@export var jump_force = 700
@export var player_health = 3

@onready var ui = %healthDisplay
@onready var ap = $AnimationPlayer

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 500
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
		$JumpAudio.play()
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	if horizontal_direction != 0:
		switch_direction(horizontal_direction)
	
	move_and_slide()
	update_animations(horizontal_direction)

func _process(delta):
	ui.set_text(" " + str(player_health))
	
# Function that defines player damage & death
func take_damage():
	player_health -= 1
	if player_health <= 0:
		speed = 0
		jump_force = 0

func update_animations(horizontal_direction):
	if player_health > 0:
		if is_on_floor():
			if horizontal_direction == 0:
				ap.play("idle")
			else:
				ap.play("run")
		elif !is_on_floor():
			if velocity.y < 0:
				ap.play("jump")
			elif velocity.y > 0:
				ap.play("fall")
	else:
		ap.play("death")
		ap.play("dead")

func switch_direction(horizontal_direction):
	$Sprite2D.flip_h  = (horizontal_direction == -1)
	if horizontal_direction < 0:
		$Sprite2D.position.x = horizontal_direction * 20
	elif horizontal_direction > 0:
		$Sprite2D.position.x = horizontal_direction * 2
