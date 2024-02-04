extends Control
class_name DialogScreen

# velocidade com que o texto é modificado
var _step : float = 0.05
# cada diálogo tem um índice
var _id : int = 0
# mensagem 
var data : Dictionary = {}
@export_category('Objects')
@export var _faceset : TextureRect = null
@export var _dialog : RichTextLabel = null
@export var _name : Label = null

func _ready() -> void:
	_initialize_dialog()
	
# atualizar de uma mensagem para outra 
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_accept') and _dialog.visible_ratio < 1:
		# diminuir o tempo, pois assim a mensagem é completa mais rápido
		_step = 0.01
		return
	# terminou a frase
	_step = 0.05
	if Input.is_action_just_pressed('ui_accept'):
		_id += 1
		if _id == data.size():
			queue_free()
			return
		# caso ainda tenha diálogo a ser carregado
		_initialize_dialog()
	
func _initialize_dialog() -> void:
	_name.text = data[_id]['title']
	_dialog.text = data[_id]['dialog']
	
	_dialog.visible_characters = 0
	# enquanto o texto não estiver 100% visível, ele vai entrar dentro dessa estrutura de repetição
	while _dialog.visible_ratio < 1:
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1
		
		
		
		
		
