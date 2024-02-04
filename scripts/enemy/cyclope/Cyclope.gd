extends CharacterBody2D

var startPosition
var endPosition

# definir a velocidade
@export var speed : int = 20

# estabelecido um limite para o qual o inimigo ao chegar nele vai parar
@export var limit : float = 0.5

# guardar referência as animações
@onready var _animation = $Animation

# guardar referência ao marcador da posição final do inimigo
@export var endPoint : Marker2D

# dano do inimigo
@export var damage : float = 1

# vida do inimigo
var health : int = 8

func _ready() -> void:
	# Fará o inimigo descer três pixels para baixo
	startPosition = position
	endPosition = endPoint.global_position

func update_velocity() -> void:
	# criar uma variável para saber se o inimigo chegou na posição final e pode parar de se mover para baixo
	var direction = endPosition - position
	# criar a condição pra quando chegar ao limite
	if direction.length() < limit:
		change_direction()
	velocity = direction.normalized() * speed
	
func change_direction() -> void:
	# função para voltar para a posição inicial
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd 

# função para executar as animações
func update_animation() -> void:
	var direction : String = ''
	if velocity.x < 0:
		direction = '_left'
	elif velocity.x > 0:
		direction = '_right'
	elif velocity.y < 0:
		direction = '_up'
	elif velocity.y > 0:
		direction = '_down'
	_animation.play('walk' + direction)
	 
func _physics_process(_delta: float) -> void:
	# passar a função de movimentação e a move and slide
	update_velocity()
	move_and_slide()
	update_animation()
	dead()
	
func dead() -> void:
	if health <= 0:
		_animation.play("dead")
		await  get_tree().create_timer(1).timeout
		queue_free()

