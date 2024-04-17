extends Node2D

var card

@onready var rectLabel = $ColorRect
@onready var labelName = $ColorRect/name
@onready var labeDescription = $ColorRect/description
@onready var labeEffects = $ColorRect/effects

func _ready():
	rectLabel.visible = false
	self.input_pickable = true

func _on_mouse_entered():
	rectLabel.visible = true
	labelName.text = card.name
	labeDescription.text = card.description
	self.scale = Vector2(0.8, 0.8)


func _on_mouse_exited():
	rectLabel.visible = false
	self.scale = Vector2(0.7, 0.7)
