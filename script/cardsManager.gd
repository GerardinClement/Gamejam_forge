class_name CardManager

extends Node2D

var Card = preload("res://script/cardsClass.gd").Card
var cards = {}

func _ready():
	load_cards()

func load_cards():
	var theFool = Card.new("TheFool", "Are you dumb, stupid, or dumb, huh?", "stats", {"strength": 1,"attack_speed": 0.10, "pv_max": 1})
	var theDevil = Card.new("TheDevil", "The devil", "stats", {"strength": 20, "pv_max": -2})
	var champagneJerseys = Card.new("ChampagneJerseys", "Give heal", "consumable", {"pv": 1})
	var flashMcqueen = Card.new("FlashMcqueen", "Focus. Speed. I am speed", "stats", {"speed": 10, "attack_speed": 0.33})
	var rainyDay = Card.new("RainyDay", "take out the umbrellas", "stats", {"n_bullet": 1})
	var stoneHeart = Card.new("StoneHeart", "away the stony heart out of your flesh, and I will give you a heart of flesh", "stats", {"shield": 1})
	
	cards["theFool"] = theFool
	cards["champagneJerseys"] = champagneJerseys
	cards["rainyDay"] = rainyDay
	cards["flashMcqueen"] = flashMcqueen
	cards["theDevil"] = theDevil
	cards["stoneHeart"] = stoneHeart
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
