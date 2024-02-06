extends CharacterBody2D

class_name  player

# CRiar a variável para a velocidade do player
@export var speed : int = 70

# Guardar referência ao animation player
@onready var animation : AnimationPlayer = $Animation

# vida do player
@export var maxHealth : float = 10.0
@onready var currentHealth : float = 10.0

# dano do player
var damage : int = 6

func _ready() -> void:
	$Lifebar.show_percentage = false
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
	$Lifebar.value = maxHealth
	handleInput()
	move_and_slide()
	_attack()
	updateAnimation()
	handleCollision()
	_idle()
	_dead()
	recovery_health()
	
func _on_damage_area_body_entered(body) -> void:
	if body.is_in_group('enemy'):
		maxHealth -= body.damage
		animation.play('hit')
		
func _dead() -> void:
	if maxHealth == 0:
		animation.play('dead')
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()
		
func _attack() -> void:
	if Input.is_action_just_pressed('attack_right'):
		animation.play('attack_right')
	elif Input.is_action_just_pressed('attack_left'):
		animation.play('attack_left')
	elif Input.is_action_just_pressed('attack_up'):
		animation.play('attack_up')
	elif Input.is_action_just_pressed('attack_down'):
		animation.play('attack_down')

func _on_animation_animation_finished(anim_name: String) -> void:
	match anim_name:
		'hit':
			set_physics_process(true)


func _on_attack_area_body_entered(body) -> void:
	if body.is_in_group('enemy'):
		body.health -= damage
		body._animation.play('hit') 

# função para lidar com a colisão do outro inimigo, no caso o bluefire
func handleCollision() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func recovery_health() -> void:
	if maxHealth < 5:
		await get_tree().create_timer(16).timeout
		maxHealth += 1
	else:
		maxHealth = currentHealth

