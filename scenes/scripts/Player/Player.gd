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

# variavel booleana, ativa se o jogador estiver atacando
@export var attacking = false

var max_health = 2
var health = 0
var can_take_damage = true

# função _ready() é chamada quando o script é adicionado à cena e está pronto para uso
func _ready():
	health = max_health
	# seta GamaManager.player para a instância atual do script
	GameManager.player = self
	#if !attacking:
		#$AttackArea/CollisionShape2D.disabled = true

# função chamada a cada frame
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

# função chamada a cada frame, lida com atualização de movimentação, gravidade e animações
func _physics_process(delta):
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		#$AttackArea/CollisionShape2D = abs($AttackArea/CollisionShape2D.scale.x) * -1
		$Area2D.scale.x = abs($Area2D.scale.x) * -1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
		$Area2D.scale.x = abs($Area2D.scale.x)
		$AttackArea.scale.x = abs($AttackArea.scale.x)
	
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
	# faz as animações se não estiver atacando
	if !attacking:
		if velocity.x:
			animation.play("run")
		else:
			animation.play("idle")
			
		if velocity.y <0:
			animation.play("jump")
		elif velocity.y >0:
			animation.play("fall")

#TODO: JOGADOR TOMA DANO SE ALGO ENCOSTAR NA HITBOX DA ESPADA
#função para respawnar o jogador quando ele morre
func death():
	GameManager.respawn_player()
	
# função para ataque
func attack():
	# verifica tudo dentro da area de colisão da area de ataque
	var overlapping_objects = $AttackArea.get_overlapping_areas()

	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().death()
	attacking = true
	# reproduz animação de ataque
	animation.play("attack")
	
func take_damage(damage_amount : int):
	if can_take_damage:
		iframes()
		health-=damage_amount
		
	if health <= 0:
		death()

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true
	
