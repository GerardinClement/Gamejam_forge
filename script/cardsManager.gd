class_name CardManager

extends Node2D

var Card = preload("res://script/cardsClass.gd").Card
var cards = {}

func _ready():
	load_cards()

func load_cards():
	var theFool = Card.new("The Fool", "Are you dumb, stupid, or dumb, huh?", "stats", {"strength": 1,"attack_speed": 0.10, "pv_max": 1})
	var theDevil = Card.new("The Devil", "The devil", "stats", {"strength": 25, "pv_max": -1})
	var champagneJerseys = Card.new("Champagne Jerseys", "Give heal", "consumable", {"pv": 1})
	var flashMcqueen = Card.new("Flash Mcqueen", "Focus. Speed. I am speed", "stats", {"speed": 10, "attack_speed": 0.33})
	var rainyDay = Card.new("Rainy Day", "take out the umbrellas", "stats", {"n_bullet": 1})
	var stoneHeart = Card.new("Stone Heart", "away the stony heart out of your flesh, and I will give you a heart of flesh", "stats", {"shield": 1})
	var temperance = Card.new("Temperance", "", "stats", {"speed": 10, "attack_speed": 0.10, "strength": 10, "pv_max": 1})
	var wheelOfFortune = Card.new("Wheel Of Fortune", "", "consumable", {"random_money": 10})
	var strength = Card.new("Strength", "", "stats", {"strength": 30})
	var theLovers = Card.new("The Lovers", "", "stats", {"pv_max": 2})
	var sequelles = Card.new("Sequelles", "", "consumable", {"pv_max": -3, "attack_speed": 0.15, "n_bullet": 1})
	var theStar = Card.new("The Star", "Increase the level of one random card", "consumable", {"empty": true})
	var oneWayTrip = Card.new("One Way Trip", "Fixed pv to 1: stats x heart lost", "consumable", {"empty": true})
	
	cards["theFool"] = theFool
	cards["champagneJerseys"] = champagneJerseys
	cards["rainyDay"] = rainyDay
	cards["flashMcqueen"] = flashMcqueen
	cards["theDevil"] = theDevil
	cards["stoneHeart"] = stoneHeart
	cards["temperance"] = temperance
	cards["wheelOfFortune"] = wheelOfFortune
	cards["strength"] = strength
	cards["theLovers"] = theLovers
	cards["theStar"] = theStar
	cards["oneWayTrip"] = oneWayTrip
	Global.allCards = cards
	
func generate_random_card(deck):
	var size = deck.size()
	if size == 0:
		return null
	var random_key = deck.keys()[randi() % size]
	return duplicate_card(Global.allCards[random_key])

func duplicate_card(original_card):
	var new_card = Card.new(original_card.name, original_card.description, original_card.type, original_card.effects)
	#new_card.image = original_card.image.duplicate()
	new_card.level = original_card.level
	return new_card
	
func theStarEffect(player):
	var rand_key_card = player.cards.keys()[randi() % player.cards.size()]
	while rand_key_card == "The Star":
		rand_key_card = player.cards.keys()[randi() % player.cards.size()]
	var cardsArr = player.cards[rand_key_card]
	cardsArr[randi() % player.cards[rand_key_card].size()].increase_level()

func oneWayTripEffect(player):
	player.strength *= player.pv_max - 1
	player.speed *= player.pv_max - 1
	player.n_bullet *=  - 1
	player.attack_speed -= player.attack_speed  - (player.pv_max / 10)
	if player.attack_speed <= 0:
		player.attack_speed = 0.1
	if player.speed > 500:
		player.speed = 500
	player.pv_max = 1
	player.pv = 1
		
