class_name GUI

extends Control

@onready var fullHeart = preload("res://Assets/Interface/FullHeart.png")
@onready var halfHeart = preload("res://Assets/Interface/HalfHeart.png")
@onready var emptyHeart = preload("res://Assets/Interface/emptyHeart.png")
@onready var shield = preload("res://Assets/Interface/shield.png")
var createInstance = preload("res://script/createInstance.gd").new()

func _ready():
	$Inventory/Coin/AnimatedSprite2D.play('default')

func actualize_gui():
	display_cards()
	display_life(Global.player)
	
func display_cards():
	var i = 0
	remove_cards()
	for cardsArray in Global.player.cards.values():
		for card in cardsArray:
			var marker = $Markers.get_child(i)
			var card_instance = createInstance.create_card($Cards, card, marker.position, false)
			card_instance.scale = Vector2(0.6, 0.6)
			i += 1
			
func remove_cards():
	Global.cardMouseOn = null
	for i in $Cards.get_child_count():
		$Cards.get_child(i).queue_free()

func display_life(player):
	remove_life()
	var textureRect = $Life/HeartIcon
	for i in player.pv_max:
		var textureDup = textureRect.duplicate()
		if abs(player.pv - int(player.pv)) > 0 and i == int(player.pv) and player.pv > 0:
			textureDup.set_texture(halfHeart)
		elif i >= player.pv:
			textureDup.set_texture(emptyHeart)
		textureDup.position.x = (textureRect.position.x + (textureRect.size.x / 1.75)) * i
		textureDup.visible = true
		$Life.add_child(textureDup)
	textureRect = $Life/ShieldIcon
	print("shield:", player.shield)
	for i in player.shield:
		var textureDup = textureRect.duplicate()
		textureDup.position.x = (textureRect.position.x + (textureRect.size.x / 1.75)) * (i + player.pv_max)
		textureDup.visible = true
		$Life.add_child(textureDup)

func remove_life():
	var container = $Life
	var childCount = container.get_child_count()
	for i in childCount:
		if i != 0 and container.get_child(i).name != "ShieldIcon":
			container.get_child(i).queue_free()

func _process(delta):
	$Inventory/Coin/Amount.text = str(Global.player.money)
	$Inventory/Piece_of_cards/Amount.text = str(Global.player.pieces_of_cards)
