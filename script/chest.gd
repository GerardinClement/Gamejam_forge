extends StaticBody2D

var cardManager = preload("res://script/cardsManager.gd").new()
var playerInZone = false
var open = false
@onready var chestMenu = $"../../Player/Camera2D/ChestMenu"

func _ready():
	$AnimatedSprite2D.play("idle")

func createCards():
	var cardsForChoose: Array
	for i in 3:
		var card = cardManager.generate_random_card(Global.allCards)
		cardsForChoose.append(card)
	return cardsForChoose

func _process(delta):
	if Input.is_action_just_pressed("Interact") and playerInZone and !open:
		$AnimatedSprite2D.play("open")


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		playerInZone = true


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		playerInZone = false


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "open":
		open = true
		Global.pause = true
		chestMenu.open(createCards())
		set_process(false)
		$AnimatedSprite2D.play("already_use")
