extends Control

@onready var cards = preload("res://cards.tscn")
@onready var animatedSprite = $AnimatedSprite2D2
@onready var marker = $Marker2D

func displayShop():
	var size = self.size
	
	for i in 3:
		var card_instance = cards.instantiate()
		card_instance.card = Global.allCards["firstOne"]
		card_instance.position = Vector2(marker.position.x + 125 * i, marker.position.y)
		print(card_instance.position)
		card_instance.scale = Vector2(0.7, 0.7)
		self.add_child(card_instance)
		var sprite = card_instance.get_child(1)
		var cardTexture =card_instance.card.image
		sprite.texture = cardTexture

func open():
	animatedSprite.play("default")
	
func close():
	var count = self.get_child_count()
	for i in count:
		var child = self.get_child(i)
		if child.name.find("StaticBody2D") >= 0 or child.name == "Cards":
			child.queue_free()


func _on_animated_sprite_2d_2_animation_finished():
	displayShop()
