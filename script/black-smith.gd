extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D
@onready var shopMenu = $"../Player/Camera2D/Black-smithShop"
@onready var cardManager = CardManager.new()
var player_in_chat_zone = false
var shopOpen = false
var shop: Dictionary

func _ready():
	animatedSprite.play("idle")
	
func _process(delta):
	if Input.is_action_just_pressed("Interact") and player_in_chat_zone:
		if animatedSprite.animation == "idle":
			animatedSprite.play("talk")
		else:
			animatedSprite.play("idle")
		displayShop()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_chat_zone = true


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_chat_zone = false
		
func generate_shop():
	for i in 3:
		var card = cardManager.generate_random_card(Global.allCards)
		shop[card.name] = card
		
func displayShop():
	if shop.is_empty():
		generate_shop()
	if shopOpen:
		shopMenu.hide()
		shopMenu.close()
		shopOpen = false
	else:
		shopMenu.show()
		shopMenu.open(shop)
		shopOpen = true
	Global.pause = shopOpen
