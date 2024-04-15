extends Control

func displayPlayerCards(player):
	var i = 1
	for card in player.cards.values():
		print("card.name: ", card.name, ", card.image: ", card.image)
		var cardNode = self.get_child(i)
		var sprite = cardNode.find_child("Sprite2D")
		sprite.set_texture(card.image)	
		

func open(player):
	displayPlayerCards(player)
	print("open")
	
func close():
	print("close")
