extends Node2D

@onready var Card = preload("res://Cards.gd").Card
var cards = {}

func _ready():
	load_cards()

func load_cards():
	var firstOne = Card.new("FirstOne", "This is the First one", "stats", {"strength": 10,"attack_speed": 10, "pv_max": 10 })
	var heal = Card.new("Health+", "Give heal", "stats", {"pv_max": 20})
	var flashMcqueen = Card.new("FlashMcqueen", "Focus. Speed. I am speed", "stats", {"speed": 10, "attack_speed": 0.33})
	var mirror = Card.new("Mirror", "Shoot in back", "gadget", {"shootSide": ["back", "topBack", "top", "topForward", "bottom", "bottomBack", "bottomForward"]})
	
	cards["firstOne"] = firstOne
	cards["health+"] = heal
	cards["mirror"] = mirror
	cards["flashMcqueen"] = flashMcqueen
	
func generate_random_card():
	var size = cards.size()
	if size == 0:
		return null
	var random_key = cards.keys()[randi() % size]
	return cards[random_key]
