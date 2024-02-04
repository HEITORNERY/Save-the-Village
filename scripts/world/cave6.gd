extends Area2D

# variável para o player
var player_ref : player = null

func _on_body_entered(body):
	if body is player:
		player_ref = body
		get_tree().change_scene_to_file('res://scenes/world/CAVE/cave_world2.tscn')
