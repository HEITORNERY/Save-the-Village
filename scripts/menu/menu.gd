extends Control

func _ready():
	$AudioStreamPlayer.play()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_accept'):
		get_tree().change_scene_to_file('res://scenes/world/initial_scene.tscn')
	elif Input.is_action_just_pressed('ui_select'):
		get_tree().change_scene_to_file('res://scenes/credits/credits.tscn')
	elif Input.is_action_just_pressed('end_screen'):
		get_tree().quit()
