extends StaticBody2D

var cardManager = preload("res://script/cardsManager.gd").new()
var playerIn = false

#func instantiate_card(cardName:String, pos: Vector2, playAnimation:bool):
	#var card_instance = cards.instantiate()
	#card_instance.card = shop[cardName]
	#if (card_instance.card == null):
		#return
	#self.add_child(card_instance)
	#var sprite = card_instance.get_child(1)
	#var cardTexture = card_instance.card.image
	#sprite.texture = cardTexture
	#cardsInstance.append(card_instance)
	#card_instance.scale = Vector2(0.7, 0.7)
	#if not playAnimation:
		#card_instance.position = Vector2(pos.x, pos.y)
	#return card_instance

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func createCards():
	var cardsForChoose: Array
	for i in 3:
		cardsForChoose.append(cardManager.generate_random_card(Global.allCards))
	return cardsForChoose

func _process(delta):
	if Input.is_action_just_pressed("Interact") and playerIn:
		createCards()
		$AnimatedSprite2D.play("open")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		playerIn = true
