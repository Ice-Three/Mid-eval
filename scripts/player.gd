extends CharacterBody2D

@export var speed = 500
@export var gravity = 30
@export var jump_force = 700

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

func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")

func switch_direction(horizontal_direction):
	$Sprite2D.flip_h  = (horizontal_direction == -1)
	if horizontal_direction < 0:
		$Sprite2D.position.x = horizontal_direction * 20
	elif horizontal_direction > 0:
		$Sprite2D.position.x = horizontal_direction * 2
