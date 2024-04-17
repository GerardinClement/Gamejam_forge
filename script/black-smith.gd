extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D
var player_in_chat_zone = false
var shopOpen = false
@onready var shopMenu = $"../Player/Camera2D/Black-smithShop"

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
		
func displayShop():
	if shopOpen:
		shopMenu.hide()
		shopMenu.close()
		shopOpen = false
	else:
		shopMenu.show()
		shopMenu.open()
		shopOpen = true
	Global.pause = shopOpen
