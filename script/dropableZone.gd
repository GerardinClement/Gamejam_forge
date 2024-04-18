extends Area2D

var cardOn = false
var initialPosCard
var positionCard = Vector2(45, 75)
var mouseOn
var card

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func add_card(card, position):
	card = card
	initialPosCard = card.position
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", Vector2(position.x + positionCard.x, position.y + positionCard.y), 0.2).set_ease(Tween.EASE_OUT)
	cardOn = true
	card.isStored = true

func _on_mouse_entered():
	print("mouse on")
	mouseOn = true


func _on_mouse_exited():
	print("mouse exit")
	mouseOn = false
