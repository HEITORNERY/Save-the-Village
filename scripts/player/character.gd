extends CharacterBody2D

# CRiar a variável de velocidade
@export_category('Variables')
@export var _move_and_speed : float = 64.0

# Criar uma aceleração para o personagem, enquanto movimenta-se e uma fricção para freiar ao parar
@export var _acceleration : float = 0.2
@export var _friction : float = 0.2
# Quanto mais próximo de 1 maior esse efeito e quanto mais próximo de 0 menor

# CRiar uma nova categoria de variáveis para objetos
@export_category('Objects')
@export var _animation_tree : AnimationTree = null

var _state_machine # Variável para guardar o estado das animações da árvore de animações

func _ready() -> void:
	_state_machine = _animation_tree['parameters/playback']

# Chamar a função de update da godot
func _physics_process(_delta: float) -> void:
	_move() # Função para lidar com a movimentação do player
	_animate() # Função para animações
	move_and_slide()
	
func _move() -> void:
	# cRIAR a variável para a direção de movimentação
	# -1 para esquerda e para cima e +1 para direita e para baixo
	var _direction : Vector2 = Vector2(Input.get_axis('ui_left', 'ui_right'),Input.get_axis('ui_up', 'ui_down') )
	
	# Adicionar a aceleração de movimentação
	if velocity != Vector2.ZERO:
		
		# Chamar as animações da árvore de animações, passando a posição na qual cada animação vai ocorrer
		_animation_tree['parameters/idle/blend_position'] = _direction
		_animation_tree['parameters/walk/blend_position'] = _direction
		
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_and_speed, _acceleration)
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_and_speed, _acceleration)
		return
		# AQui aplica-se o freio ao personagem
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_and_speed, _friction)
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_and_speed, _friction)
		
func _animate() -> void:
	if velocity.length() > 10: # Personagem está movendo-se
		_state_machine.travel('walk') # Executar as animações do tipo walk correspondente
		return
	_state_machine.travel('idle')
	
	
