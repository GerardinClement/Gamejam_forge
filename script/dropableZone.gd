extends Area2D

var cardIsOn = false
var initialPosCard
var mouseOn
var cardOn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_card(card, position):
	cardOn = card
	initialPosCard = card.position
	var tween = get_tree().create_tween()
	tween.tween_property(cardOn, "global_position", $Marker2D.global_position, 0.2).set_ease(Tween.EASE_OUT)
	cardIsOn = true
	cardOn.isStored = true
	card.dropableZoneName = self.name

func  remove_card():
	if not cardOn:
		return
	var tween = get_tree().create_tween()
	tween.tween_property(cardOn, "position", initialPosCard, 0.2).set_ease(Tween.EASE_OUT)
	cardIsOn = false
	cardOn.isStored = false
