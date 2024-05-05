class_name Merge

extends Node

var abilities1: String
var abilities2: String
var Card = preload("res://script/cardsClass.gd").Card

func get_card_abilities(card):
	var size = card.effects.size()
	var random_key = card.effects.keys()[randi() % size]
	return random_key
	
#var firstOne = Card.new("FirstOne", "This is the First one", "stats", {"strength": 10,"attack_speed": 10, "pv_max": 1 })

func increase_card_level(card, card2):
	var increasedCard = card
	var addCard = card2
	if card.level < card2.level:
		increasedCard = card2
		addCard = card
	var effects = increasedCard.effects.duplicate()
	for key in effects:
		effects[key] += addCard.effects[key]
	var new_card = Card.new(increasedCard.name, increasedCard.description, increasedCard.type, effects)
	new_card.level = increasedCard.level + 1
	return new_card

func merge_cards(card1, card2):
	var mergedCard
	
	if card1.name == card2.name:
		mergedCard = increase_card_level(card1, card2)
	else:
		abilities1 = get_card_abilities(card1)
		abilities2 = get_card_abilities(card2)
		var type = "stats"
		if card1.type == "consumable" or card2.type == "consumable":
			type = "consumable"
		mergedCard = Card.new(card1.name + card2.name, "This is a merge card", type, {abilities1: card1.effects[abilities1], abilities2: card2.effects[abilities2]})
	Global.player.cards[card1.name].remove_at(0)
	Global.player.cards[card2.name].remove_at(0)
	return mergedCard
