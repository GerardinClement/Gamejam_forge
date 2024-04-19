extends Control

@onready var cards = preload("res://cards.tscn")
@onready var CardManager = preload("res://script/cardsManager.gd")
@onready var animatedSprite = $AnimatedSprite2D2
@onready var cardManager = CardManager.new()
@onready var dropable1 = $Dropable
@onready var dropable2 = $Dropable2
var Instance = preload("res://script/createInstance.gd").new()
var Merge = preload("res://script/mergeCards.gd").new()

var shop
var cardsInstance: Array

func displayShop():
	var size = self.size
	var i = 0
	
	for key in shop:
		var marker = self.get_child(i + 1)
		Instance.create_card(self, shop[key], marker.position, false)
		i += 1
		
func add_to_dropable(card):
	if not card.isStored:
		print(card.isStored)
		if not dropable1.cardIsOn:
			dropable1.add_card(card, dropable1.position)
		elif not dropable2.cardIsOn:
			dropable2.add_card(card, dropable2.position)
	else:
		if card.dropableZoneName == "Dropable":
			dropable1.remove_card()
		else:
			dropable2.remove_card()

func open(shopCards):
	shop = shopCards
	animatedSprite.play("default")
	

func _on_animated_sprite_2d_2_animation_finished():
	displayShop()
	
func animate_forge_success(pos: Vector2, card_instance):
	card_instance.position = Vector2(pos.x + 150, pos.y + 75)
	card_instance.forge_animation(dropable1.initialPosCard)
	
func forge():
	var mergeCard = Merge.merge_cards(dropable1.cardOn.card, dropable2.cardOn.card)
	Global.player.add_card(mergeCard)
	var card_instance = Instance.create_card(self, mergeCard, dropable1.position, true)
	animate_forge_success(dropable1.position, card_instance)
	dropable1.cardIsOn = false
	dropable2.cardIsOn = false
	dropable1.cardOn.queue_free()
	dropable2.cardOn.queue_free()
	
func _on_button_pressed():
	if dropable1.cardIsOn and dropable2.cardIsOn:
		forge()

func close():
	dropable1.remove_card()
	dropable2.remove_card()
	var count = self.get_child_count()
	for i in count:
		var child = self.get_child(i)
		if child.name.find("StaticBody2D") >= 0 or child.name == "Cards":
			child.queue_free()
