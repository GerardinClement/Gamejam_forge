extends Node2D

@onready var Card = preload("res://Cards.gd").Card
var cards = {}

func _ready():
	load_cards()

func load_cards():
	var firstOne = Card.new("FirstOne", "This is the First one", {"strength": 10,"attack_speed": 10, "pv_max": 10 })
	var heal = Card.new("Health+", "Give heal", {"strength": 0,"attack_speed": 0, "pv_max": 20 })
	
	cards["firstOne"] = firstOne
	cards["health+"] = heal
	
func generate_random_card():
	var size = cards.size()
	if size == 0:
		return null
	var random_key = cards.keys()[randi() % size]
	return cards[random_key]
