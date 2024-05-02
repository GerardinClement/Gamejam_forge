extends Control

@onready var cards = preload("res://Scene/cards.tscn")
@onready var markersNode = $Markers
var Instance = preload("res://script/createInstance.gd").new()

func _on_exit_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scene/Menu.tscn")

