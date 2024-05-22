extends Node

# cria um sinal para moedas ganhas, sinais permitem a comunicação entre nós.
# quando moedas são ganhas, ativa o sinal
signal gained_coins(int)

# variavel que representa a quantidade de moedas do jogador, começa com 0
var coins = 0

# declara uma variavel do tipo Checkpoint(uma classe) que representa o checkpoint atual
var current_checkpoint : Checkpoint

# declara uma variavel do tipo Player(uma classe) que representa o jogador
var player : Player

# função chamada quando o jogador precisa respawnar
func respawn_player():
	player.health = player.max_health
	# verifica se existe um checkpoint
	if current_checkpoint != null:
		# se existe, coloca o jogador na posição global daquele checkpoint
		player.position = current_checkpoint.global_position

# função chamada quando o jogador coleta moedas
func gain_coins(coins_gained):
	# adiciona a quantidade de moedas coletadas à contagem total de moedas
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)
	print(coins)
	
