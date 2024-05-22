extends Node2D

# chamada quando o nó é adicionado à cena e está pronto para uso
func _ready():
	# acessa o nó filho do nó atual, nesse caso, "AnimationPlayer", e reproduz a animação "idle" da moeda
	$AnimationPlayer.play("idle")

# _on_area_2d_area_entered é chamado quando um nó do tipo Area2D entra na área especificada
func _on_area_2d_area_entered(area):
	# chama a função gained_coins do GameManager, passando a quantidade de moedas ganhas (1)
	GameManager.gain_coins(1)
	# remove o nó atual da cena (deleta o objeto)
	queue_free()
