extends Node2D

var card
var onShop = false
var mouseOn = false
var isStored = false
var dropableZoneName

@onready var rectLabel = $ColorRect
@onready var labelName = $ColorRect/name
@onready var labelDescription = $ColorRect/description
@onready var labelEffects = $ColorRect/effects

func _ready():
	self.scale = Vector2(0.7, 0.7)
	rectLabel.visible = false
	self.input_pickable = true
	
func _process(delta):
	if Input.is_action_just_pressed("click") and onShop and mouseOn:
		get_parent().add_to_dropable(self)

func _on_mouse_entered():
	if get_parent().name == "Black-smithShop":
		onShop = true
		mouseOn = true
	rectLabel.visible = true
	labelName.text = card.name
	labelDescription.text = card.description
	labelEffects.text = ""
	for key in card.effects:
		labelEffects.text += key + ": " + str(card.effects[key]) + "\n"
	self.scale = Vector2(0.8, 0.8)
	
func forge_animation():
	$AnimationPlayer.play("Intro")
	
func remove_card_from_forge():
	self.isStored = false


func _on_mouse_exited():
	mouseOn = false
	rectLabel.visible = false
	self.scale = Vector2(0.7, 0.7)
