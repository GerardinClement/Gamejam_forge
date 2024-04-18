extends Node2D

var card

@onready var rectLabel = $ColorRect
@onready var labelName = $ColorRect/name
@onready var labelDescription = $ColorRect/description
@onready var labelEffects = $ColorRect/effects

func _ready():
	self.scale = Vector2(0.7, 0.7)
	rectLabel.visible = false
	self.input_pickable = true

func _on_mouse_entered():
	rectLabel.visible = true
	labelName.text = card.name
	labelDescription.text = card.description
	labelEffects.text = ""
	for key in card.effects:
		labelEffects.text += key + ": " + str(card.effects[key]) + "\n"
	self.scale = Vector2(0.8, 0.8)


func _on_mouse_exited():
	rectLabel.visible = false
	self.scale = Vector2(0.7, 0.7)
