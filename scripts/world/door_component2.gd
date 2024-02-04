extends Area2D

# Nome para esse script
class_name DoorComponent2

# variável para a animação da porta abrir
@export var animation : AnimationPlayer

# variável para o player
var player_ref : player = null

func _on_body_entered(_body) -> void:
	if _body is player:
		player_ref = _body
		animation.play('open')
		
func _on_animation_animation_finished(anim_name: String) -> void:
	match anim_name:
		'open':
			get_tree().change_scene_to_file('res://scenes/world/initial_scene.tscn')
