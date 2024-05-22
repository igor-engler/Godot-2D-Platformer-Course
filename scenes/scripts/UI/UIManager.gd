extends CanvasLayer

#função _ready() é chamada quando o script é adicionado à cena e está pronto para uso
func _ready():
	#conecta o sinal gained_coins de uma instância da classe GameManager à função update_coin_display.
	#quando o sinal é emitido, a função de conexão será chamada
	GameManager.gained_coins.connect(update_coin_display)

#função para atualizar o display de moedas coletadas na tela
func update_coin_display(gained_coins):
	#altera o texto do elemento CoinDisplay, inserindo a representação textual da quantidade de moedas
	$CoinDisplay.text = str(GameManager.coins)
