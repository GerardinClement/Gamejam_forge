extends Node2D

@onready var Card = preload("res://Cards.gd").Card
var cards = {}

func _ready():
	load_cards()

func load_cards():
	var firstOne = Card.new("FirstOne", "This is the First one", {"increase_strength": 10,"increase_attack_speed": 10, "increase_health": 10 })
	var heal = Card.new("Health +", "Give heal", {"increase_strength": 0,"increase_attack_speed": 0, "increase_health": 20 })
	
	cards["firstOne"] = firstOne
	cards["heal+"] = heal
	
func generate_random_card():
	print(cards.size())
	var size = cards.size()
	if size == 0:
		return null
	var random_key = cards.keys()[randi() % size]
	return cards[random_key]
