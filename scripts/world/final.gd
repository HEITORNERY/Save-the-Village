extends Node2D
var _dialog_data : Dictionary = {
	0: {'faceset': 'res://assets3/cavaleiro/Faceset.png', 
		'dialog': 'Kleytin, você enfrentou muitos monstros no caminho até aqui! Mas agora o culpado por controlar estes monstros e trazer medo e desepero a essa vila, finalmente mostrou-se!', 
		'title': 'Cavaleiro Heitor'},
	1: {'faceset': 'res://assets3/cavaleiro/Faceset.png', 
		'dialog': 'Uma bruxa está por trás de tudo isso. Derrote ela e seremos libertos de seus ataques, mas cuidado, pois ela usa de lobos para defendê-la.', 
		'title': 'Cavaleiro Heitor'},
	2: {'faceset': 'res://assets3/cavaleiro/Faceset.png', 
		'dialog': 'Primeiro derrube suas defesas e depois enfrente a bruxa, mas cuidado, ela é muito resistente!', 
		'title': 'Cavaleiro Heitor'}
	}
@export_category('objects')
@export var hud : CanvasLayer = null

const _DIALOG_SCREEN : PackedScene = preload('res://scenes/npc/cavaleiro/dialog_screen2.tscn')

func _ready():
	$AudioStreamPlayer.play()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_select'):
			var _new_dialog : DialogScreen = _DIALOG_SCREEN.instantiate()
			_new_dialog.data = _dialog_data
			hud.add_child(_new_dialog)
