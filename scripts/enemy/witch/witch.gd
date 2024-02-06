extends CharacterBody2D

# Variável para guardar referência a posição do personagem
var _player_ref = null

# Guardar referência a textura e as animações
@export var _animation : AnimationPlayer 
@export var _texture : Sprite2D

# dano 
var damage = 1

# Criar a vida 
var health : int = 24

func _physics_process(_delta: float) -> void:
	_animate() # Função para executar as animações
	if _player_ref != null:
		if _player_ref.maxHealth == 0:
			velocity = Vector2.ZERO
			move_and_slide()
			return
		var _direction : Vector2 = global_position.direction_to(_player_ref.global_position)
		# AQui vai definir o sentido para o qual o inimigo vai perseguir o player
		# A direction_to normaliza esse valor de vector em -1 a 1
		velocity = _direction * 40 # velocidade do slime na direção do player
		move_and_slide()
	dead()
		
func _animate() -> void:
	if velocity.x < 0:
		_texture.flip_h = true
		_animation.play('walk')
	elif velocity.x > 0:
		_texture.flip_h = false
		_animation.play('walk')
	elif velocity.x == 0 or velocity.y == 0:
		_animation.play('idle')

func _on_detection_area_body_entered(body) -> void:
	if body.is_in_group('character'):
		_player_ref = body # A referência ao player foi criada
		
func _on_detection_area_body_exited(body) -> void:
	if body.is_in_group('character'):
		_player_ref = null # PLayer saiu da área de detecção
		velocity = Vector2.ZERO

func _on_animation_animation_finished(anim_name: String) -> void:
	match anim_name:
		'dead': 
			queue_free()

func dead() -> void:
	if health <= 0:
		_animation.play('dead')

func _on_hit_area_body_entered(body) -> void:
	if body.is_in_group('character'):
		_animation.play('attack')
