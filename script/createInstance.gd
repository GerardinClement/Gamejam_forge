class_name Instance

extends Node

var cards = preload("res://cards.tscn")

func create_card(parent, card, pos: Vector2,  playAnimation:bool):
	var card_instance = cards.instantiate()
	card_instance.card = card
	if (card_instance.card == null):
		return
	parent.add_child(card_instance)
	var sprite = card_instance.get_child(1)
	var cardTexture = card_instance.card.image
	sprite.texture = card.loadImage()
	card_instance.scale = Vector2(0.7, 0.7)
	if not playAnimation:
		card_instance.position = Vector2(pos.x, pos.y)
	return card_instance
