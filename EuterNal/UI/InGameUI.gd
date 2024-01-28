extends Control

@onready var health = %healthDisplay

func update_health(x):
	health.set_text(" " + x)

