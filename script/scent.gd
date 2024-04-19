extends Node2D

var player

func _ready():
	pass

func _on_timer_timeout():
	player.scent_trail.erase(self)
	queue_free()
