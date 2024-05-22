extends Node2D

# define a classe Checkpoint
class_name Checkpoint

# export deixa a variavel visivel no editor
# declara o ponto de spawn para o checkpoint
@export var spawn_point = false

# variavel para informar se o checkpoint está ativo
var activated = false

# chamada quando o nó é adicionado à cena e está pronto para uso
func _ready():
	# reproduz a animação da bandeira
	$AnimationPlayer.play("activated")
	# verifica se o existe um spawn_point
	if spawn_point:
		# se sim, chama a função activate
		activate()

func activate():
	# seta o checkpoint atual no GameManager
	GameManager.current_checkpoint = self
	# marca o checkpoint como ativo
	activated = true
	
# chamado quando um nó do tipo Area2D entra na área especificada
func _on_area_2d_area_entered(area):
	# verifica se o Area2D que entrou na área é filho do jogador e se o checkpoint ainda não está ativo
	if area.get_parent() is Player && !activated:
		# se sim, ele ativa o checkpoint
		activate()
