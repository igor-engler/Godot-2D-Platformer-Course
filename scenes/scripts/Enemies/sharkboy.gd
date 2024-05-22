extends CharacterBody2D

#negativo porque ele está olhando pra esquerda
var speed = -60.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false

var dead = false

func _ready():
	$AnimationPlayer.play("run")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# se o raio não esta tocando nada e o personagem está no chão
	if (!$RayCast2D.is_colliding() && is_on_floor()) || is_on_floor && $RayCast2D2.is_colliding():
		#chama a função flip para virar o personagem, pq ele chegou em uma borda
		flip()

	velocity.x = speed
	move_and_slide()
	
func flip():
	# troca o lado
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1


func _on_hitbox_area_entered(area):
	
	#verifica se o nó que contém a Area2D é o jogador
	if area.get_parent() is Player && !dead:
		print("colidiu")
		print("arruma aqui")
		#se for, chama a função death
		#area.get_parent().death()

func death():
	dead = true
	speed = 0
	#queue_free()
	$AnimationPlayer.play("die")
