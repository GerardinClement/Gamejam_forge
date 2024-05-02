extends StaticBody2D

var card_manager = preload("res://script/cardsManager.gd").new()
var player_in = false
var price = 5

func _process(delta):
	if Input.is_action_just_released("Interact") and player_in:
		if Global.player.pieces_of_cards >= price:
			create_card()
			Global.player.pieces_of_cards -= price
			
func create_card():
	print("create Card")
	Global.player.add_card(card_manager.generate_random_card(Global.allCards))
	Global.player.gui.display_cards()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$Control.visible = true
		player_in = true


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		$Control.visible = false
		player_in = false
