extends Control

@onready var health = %healthDisplay

func update_health(x):
	health.set_text(" " + x)



func _on_mainmenu_button_down():
	get_tree().change_scene_to_file("res://scenes/titleScreen.tscn")
