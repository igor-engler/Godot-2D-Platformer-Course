extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")


func _on_area_2d_area_entered(area):
	#verifica se o nó que contém a Area2D é o jogador
	if area.get_parent() is Player and area.get_parent().health < area.get_parent().max_health:
		#se for, chama a função death
		area.get_parent().health += 1
		#area.get_parent().max_health += 1
		queue_free()
		
		print(area.get_parent().health)
		print(area.get_parent().max_health)
