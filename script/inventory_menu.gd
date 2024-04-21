extends Control

@onready var cards = preload("res://cards.tscn")
@onready var markersNode = $Markers
var Instance = preload("res://script/createInstance.gd").new()


func displayPlayerCards(player):
	var viewport_rect = get_viewport_rect()
	var bottom_position = viewport_rect.size.y * 0.83
	var left_position = viewport_rect.size.x / 2

	var i = 0
	for cardsArray in player.cards.values():
		for card in cardsArray:
			var marker = self.markersNode.get_child(i)
			Instance.create_card(self, card, marker.position, false)
			i += 1

func open(player):
	displayPlayerCards(player)
	_print_money_amount()
	
func close():
	var count = self.get_child_count()
	for i in count:
		var child = self.get_child(i)
		if child.name.find("StaticBody2D") >= 0 or child.name == "Cards":
			child.queue_free()

func _print_money_amount():
	$Money.text = str(Global.playerMoney)
	
func _on_exit_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Menu.tscn")

