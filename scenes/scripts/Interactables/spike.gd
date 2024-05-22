extends Node2D

#_on_area_2d_area_entered é chamado quando um nó do tipo Area2D entra na área especificada
func _on_area_2d_area_entered(area):
	#verifica se o nó que contém a Area2D é o jogador
	if area.get_parent() is Player:
		#se for, chama a função death
		area.get_parent().death()
