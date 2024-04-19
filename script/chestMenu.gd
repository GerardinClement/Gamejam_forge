extends Control

var Instance = preload("res://script/createInstance.gd").new()
@onready var markers = $Markers
var cards_instance: Array
var cardChooseInstance
var isClose = true


func add_cards(cardsToChoose):
		var i = 0
		for card in cardsToChoose:
			var marker = markers.get_child(i)
			var card_instance = Instance.create_card(self, card, marker.position, false)
			card_instance.forChoose = true
			cards_instance.append(card_instance)
			i += 1
			
func open(cardsToChoose):
	self.isClose = false
	add_cards(cardsToChoose)
	self.show()
	
func close():
	Global.pause = false
	self.hide()
	var count = self.get_child_count()
	for i in count:
		var child = self.get_child(i)
		if child.name.find("StaticBody2D") >= 0 or child.name == "Cards":
			child.queue_free()
			
func check_if_animations_finished(animName):
	for card_instance in cards_instance:
		if card_instance.animationsFinished.has("vortex"):
			return true
	return false

func _process(_delta):
	#if not cards_instance:
		#return
	if not self.isClose:
		for card_instance in cards_instance:
			if card_instance.isSelected:
				cardChooseInstance = card_instance
				card_instance.animationPlayer.play("Intro")
				Global.player.cards[card_instance.card.name] = card_instance.card
				delete_cards()
				card_instance.isSelected = false
				self.isClose = true
	if self.isClose and check_if_animations_finished("vortex"):
		set_process(false)
		close()
			
func delete_cards():
	for card_instance in cards_instance:
		if not card_instance.isSelected:
			card_instance.destroy_card()
	self.isClose = true


func _on_button_pressed():
	set_process(false)
	isClose = true
	close()
