extends Control

@onready var cards = preload("res://cards.tscn")
@onready var markersNode = $Markers


func displayPlayerCards(player):
	var viewport_rect = get_viewport_rect()
	var bottom_position = viewport_rect.size.y * 0.83
	var left_position = viewport_rect.size.x / 2

	var i = 2
	for card in player.cards.values():
		var marker = self.markersNode.get_child(i)
		var card_instance = cards.instantiate()
		card_instance.card = player.cards[card.name]
		card_instance.position = Vector2(marker.position.x, marker.position.y)
		self.add_child(card_instance) 
		var cardNode = self.get_child(i)
		var sprite = cardNode.find_child("Card")
		if sprite:
			sprite.set_texture(card.image)
		i += 1
		

func open(player):
	displayPlayerCards(player)
	
func close():
	var count = self.get_child_count()
	for i in count:
		var child = self.get_child(i)
		if child.name.find("StaticBody2D") >= 0 or child.name == "Cards":
			child.queue_free()
