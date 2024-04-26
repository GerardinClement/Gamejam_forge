class_name CardManager

extends Node2D

var Card = preload("res://script/cardsClass.gd").Card
var cards = {}

func _ready():
	load_cards()

func load_cards():
	var firstOne = Card.new("FirstOne", "This is the First one", "stats", {"strength": 10,"attack_speed": 10, "pv_max": 1 })
	var theDevil = Card.new("TheDevil", "The devil", "stats", {"strength": 20, "pv_max": -2})
	var heal = Card.new("Health+", "Give heal", "stats", {"pv_max": 1})
	var flashMcqueen = Card.new("FlashMcqueen", "Focus. Speed. I am speed", "stats", {"speed": 10, "attack_speed": 0.33})
	var mirror = Card.new("Mirror", "Shoot in back", "gadget", {"shootSide": ["back", "topBack", "top", "topForward", "bottom", "bottomBack", "bottomForward"]})
	
	cards["firstOne"] = firstOne
	#cards["health+"] = heal
	#cards["mirror"] = mirror
	#cards["flashMcqueen"] = flashMcqueen
	#cards["theDevil"] = theDevil
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
