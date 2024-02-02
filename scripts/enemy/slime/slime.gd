extends CharacterBody2D

# Atribuindo um nome para esse script
class_name Slime

# Variável para guardar referência a posição do personagem
var _player_ref = null

# Guardar referência a textura e as animações
@export var _animation : AnimationPlayer 
@export var _texture : Sprite2D

# dano do slime
var damage = 5

# Criar a vida do slime
var health : int = 4

func _physics_process(_delta: float) -> void:
	_animate() # Função para executar as animações
	if _player_ref != null:
		if _player_ref.health == 0:
			velocity = Vector2.ZERO
			move_and_slide()
			return
		
		var _direction : Vector2 = global_position.direction_to(_player_ref.global_position)
		# AQui vai definir o sentido para o qual o inimigo vai perseguir o player
		# A direction_to normaliza esse valor de vector em -1 a 1
		velocity = _direction * 40 # velocidade do slime na direção do player
		move_and_slide() 
		
func _animate() -> void:
	if velocity.x < 0:
		_texture.flip_h = true
		_animation.play('walk')
	elif velocity.x > 0:
		_texture.flip_h = false
		_animation.play('walk')
	else:
		_animation.play('idle')

func _on_detection_area_body_entered(body) -> void:
	if body.is_in_group('character'):
		_player_ref = body # A referência ao player foi criada
		_animation.play('attack')
		
func _on_detection_area_body_exited(body) -> void:
	if body.is_in_group('character'):
		_player_ref = null # PLayer saiu da área de detecção

func _on_animation_animation_finished(anim_name: String) -> void:
	match anim_name:
		'attack':
			set_physics_process(true)