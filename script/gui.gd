class_name GUI

extends Control

@onready var fullHeart = preload("res://Assets/Interface/FullHeart.png")
@onready var halfHeart = preload("res://Assets/Interface/HalfHeart.png")
@onready var emptyHeart = preload("res://Assets/Interface/emptyHeart.png")
@onready var shield = preload("res://Assets/Interface/shield.png")

func _ready():
	$Coin/AnimatedSprite2D.play('default')

func display_life(player):
	remove_life()
	var textureRect = $Heart/TextureRect
	for i in player.pv_max:
		var textureDup = textureRect.duplicate()
		if abs(player.pv - int(player.pv)) > 0 and i == int(player.pv) and player.pv > 0:
			textureDup.set_texture(halfHeart)
		elif i >= player.pv:
			textureDup.set_texture(emptyHeart)
		textureDup.position.x = (textureRect.position.x + (textureRect.size.x * 1.33)) * i
		textureDup.visible = true
		$Heart.add_child(textureDup)
	for i in player.shield:
		var textureDup = textureRect.duplicate()
		textureDup.set_texture(shield)
		textureDup.position.x = (textureRect.position.x + (textureRect.size.x * 1.33)) * (i + player.pv_max)
		textureDup.visible = true
		$Heart.add_child(textureDup)

func remove_life():
	var container = $Heart
	var childCount = container.get_child_count()
	for i in childCount:
		if i != 0:
			container.get_child(i).queue_free()
	

func _process(delta):
	$Coin/Amount.text = str(Global.player.money)
