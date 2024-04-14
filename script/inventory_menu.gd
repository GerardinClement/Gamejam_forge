extends Control

func displayPlayerCards(player):
	for card in player.cards.values():
		print("display Card:", card.name)

func open(player):
	displayPlayerCards(player)
	print("open")
	
func close():
	print("close")
