extends Node2D

var _dialog_data : Dictionary = {
	0: {'faceset': 'res://assets3/ninjaazul/Faceset.png', 
		'dialog': 'Kleytin, estamos com problemas! MONSTROS invadiram a região e são muitos para derrotarmos sozinhos. Precisamos do nosso protetor. Por favor, nos ajude!', 
		'title': 'Guerreiro Venâncio'},
	1: {'faceset': 'res://assets3/ninjaazul/Faceset.png', 
		'dialog': 'Existem espíritos, que entraram em diversas residências e causaram pânico, verifique a sua!', 
		'title': 'Guerreiro Venâncio'}
	}
@export_category('objects')
@export var hud : CanvasLayer = null

const _DIALOG_SCREEN : PackedScene = preload('res://scenes/dialog/dialog_screen.tscn')

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_select'):
			var _new_dialog : DialogScreen = _DIALOG_SCREEN.instantiate()
			_new_dialog.data = _dialog_data
			hud.add_child(_new_dialog)
