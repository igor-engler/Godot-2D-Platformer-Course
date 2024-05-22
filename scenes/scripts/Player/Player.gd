extends CharacterBody2D

# especifica que esse código representa a classe Player
class_name Player

# @onready garante que a variavel será inicializada
# conectam animação e sprite com seus nós
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

# variaveis para velocidade e altura do pulo
@export var speed = 300.0
@export var jump_height = -400.0

# pega o valor padrão de gravidade das configurações do projeto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# função _ready() é chamada quando o script é adicionado à cena e está pronto para uso
func _ready():
	# seta GamaManager.player para a instância atual do script
	GameManager.player = self

# função chamada a cada frame, lida com atualização de movimentação, gravidade e animações
func _physics_process(delta):
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	
	# adiciona gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# pula
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_height

	# Recebe a direção do input e lida com movimento/desaceleração
	var direction = Input.get_axis("left", "right")
	if direction:
		# se o jogador se movimenta, adiciona velocidade
		velocity.x = direction * speed
	else:
		# senão, jogador desacelera até 0
		velocity.x = move_toward(velocity.x, 0, speed)

	update_animation()
	# função para lidar com colisão e movimentação
	move_and_slide()
	
	if position.y >=600:
		death()

# ativa as animações de acordo com velocidade horizontal e vertical
func update_animation():
	if velocity.x:
		animation.play("run")
	else:
		animation.play("idle")
		
	if velocity.y <0:
		animation.play("jump")
	elif velocity.y >0:
		animation.play("fall")

#função para respawnar o jogador quando ele morre
func death():
	GameManager.respawn_player()
