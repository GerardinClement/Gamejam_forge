extends Control

var Instance = preload("res://script/createInstance.gd").new()
@onready var markers = $Markers
var cards_instance: Array


func add_cards(cardsToChoose):
		var i = 0
		for card in cardsToChoose:
			var marker = markers.get_child(i)
			var card_instance = Instance.create_card(self, card, marker.position, false)
			card_instance.forChoose = true
			cards_instance.append(card_instance)
			i += 1
			
func open(cardsToChoose):
	add_cards(cardsToChoose)
	self.show()
	
func close():
	self.hide()
	var count = self.get_child_count()
	for i in count:
		var child = self.get_child(i)
		if child.name.find("StaticBody2D") >= 0 or child.name == "Cards":
			child.queue_free()

func process():
	#if not cards_instance:
		#return
	for card_instance in cards_instance:
		if card_instance.isSelected:
			pass
