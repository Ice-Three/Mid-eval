extends CharacterBody2D

@export var speed = 500
@export var gravity = 30
@export var jump_force = 950
@export var player_health = 3

@onready var playerSprite = %Sprite2D

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 500
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
	
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
	print(velocity)
	
	
func _process(delta):
	%healthDisplay.text = str(" " + str(player_health))

# Function that defines player damage & death
func take_damage():
	player_health -= 1
	
	if player_health <= 0:
		speed = 0
		
		
