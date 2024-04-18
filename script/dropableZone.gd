extends Area2D

var cardIsOn = false
var initialPosCard
var positionCard = Vector2(45, 60)
var mouseOn
var cardOn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_card(card, position):
	cardOn = card
	initialPosCard = card.position
	var tween = get_tree().create_tween()
	tween.tween_property(cardOn, "position", Vector2(position.x + positionCard.x, position.y + positionCard.y), 0.2).set_ease(Tween.EASE_OUT)
	cardIsOn = true
	cardOn.isStored = true
	card.dropableZoneName = self.name

func  remove_card():
	var tween = get_tree().create_tween()
	tween.tween_property(cardOn, "position", initialPosCard, 0.2).set_ease(Tween.EASE_OUT)
	cardIsOn = false
	cardOn.isStored = false
