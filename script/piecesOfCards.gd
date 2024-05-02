extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.player.pieces_of_cards += 1
		queue_free()
