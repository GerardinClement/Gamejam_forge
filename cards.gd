extends Node2D

var card

func _ready():
	self.input_pickable = true

func _on_mouse_entered():
	self.scale = Vector2(0.8, 0.8)


func _on_mouse_exited():
	self.scale = Vector2(0.7, 0.7)
