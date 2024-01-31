extends CharacterBody2D

# CRiar a variável para a velocidade do player
@export var speed : int = 35

# Guardar referência ao animation player
@onready var animation : AnimationPlayer = $Animation

# Criar uma função para lidar com os inputs
func handleInput() -> void:
	var moveDirection = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	# Aqui a direção vai ser atribuda com base no pressionar das teclas
	velocity = moveDirection * speed
	
# Função para verificar a animação com base na velocidade
func updateAnimation() -> void:
	var direction : String = ''
	if velocity.x < 0:
		direction = '_left'
	elif velocity.x > 0:
		direction = '_right'
	elif velocity.y < 0:
		direction = '_up'
	elif velocity.y > 0:
		direction = '_down'
	animation.play('walk' + direction)
	
# Função para as animações de idle
func _idle() -> void:
	var direction = ''
	if Input.is_action_just_released('ui_right'):
		direction = '_right'
	if Input.is_action_just_released('ui_left'):
		direction = '_left'
	if Input.is_action_just_released('ui_up'):
		direction = '_up'
	if Input.is_action_just_released('ui_down'):
		direction = '_down'
	animation.play('idle' + direction)
		
func _physics_process(_delta: float) -> void:
	handleInput()
	move_and_slide()
	updateAnimation()
	_idle()
	
	
	
