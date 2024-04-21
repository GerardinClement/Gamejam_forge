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
	cards["health+"] = heal
	cards["mirror"] = mirror
	cards["flashMcqueen"] = flashMcqueen
	cards["theDevil"] = theDevil
	Global.allCards = cards
	
func generate_random_card(deck):
	var size = deck.size()
	if size == 0:
		return null
	var random_key = deck.keys()[randi() % size]
	return generate_card(random_key)

func generate_card(name):
	if name == "firstOne":
		return Card.new("FirstOne", "This is the First one", "stats", {"strength": 10,"attack_speed": 10, "pv_max": 1 })
	elif name == "health+":
		return Card.new("Health+", "Give heal", "stats", {"pv_max": 1})
	elif name == "mirror":
		return Card.new("Mirror", "Shoot in back", "gadget", {"shootSide": ["back", "topBack", "top", "topForward", "bottom", "bottomBack", "bottomForward"]})
	elif name == "flashMcqueen":
		return Card.new("FlashMcqueen", "Focus. Speed. I am speed", "stats", {"speed": 10, "attack_speed": 0.33})
	elif name == "theDevil":
		return Card.new("TheDevil", "The devil", "stats", {"strength": 20, "pv_max": -2})
