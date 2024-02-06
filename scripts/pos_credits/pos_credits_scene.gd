extends Node2D

func _ready():
	$AudioStreamPlayer.play()
func _process(_delta):
	if Input.is_action_just_pressed('end_screen'):
		get_tree().change_scene_to_file('res://scenes/menu/menu.tscn')
