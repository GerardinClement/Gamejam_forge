extends Control

func displayPlayerCards(player):
	var i = 1
	for card in player.cards.values():
		var cardNode = self.get_child(i)
		var sprite = cardNode.find_child("Card")
		if sprite:
			sprite.set_texture(card.image)
		i += 1
		

func open(player):
	displayPlayerCards(player)
	print("open")
	
func close():
	print("close")
