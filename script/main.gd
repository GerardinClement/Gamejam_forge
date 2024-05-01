extends Node2D

@onready var inventory_menu = $Player/Camera2D/InventoryMenu
@onready var Player = $Player.player
var music
var card_manager_scene = preload("res://Scene/cardsManager.tscn")
var card_manager

func _ready():
	music = $Player.get_node("Music")
	var card_manager_scene = preload("res://Scene/cardsManager.tscn")
	inventory_menu.hide()
	if not Global.gameIsStart:
		self.start_the_game()
	else:
		Player = Global.player
		if self.name != "Forge":
			$Player.position = Global.lastPosition
		else:
			music = $Player.get_node("ForgeMusic")
		music.play()
		#music.stop()

func start_the_game():
	card_manager = card_manager_scene.instantiate()
	add_child(card_manager)
	for i in 1:
		Player.add_card(card_manager.generate_random_card(card_manager.cards))
	inventory_menu.hide()
	Global.gameIsStart = true
	
func _process(_delta):
	if music && !music.playing:
		music.play()
	if Global.playerIsDead:
		music.stop()
		if !$Player.get_node("DeathSound").playing:
			$Player.get_node("DeathSound").play()
	if Input.is_action_just_pressed("Inventory"):
		inventoryMenu()
	if Input.is_action_just_pressed("EscapeMenu"):
		Global.lastPosition = $Player.position
		get_tree().change_scene_to_file("res://Scene/escapeInterface.tscn")
		
func inventoryMenu():
	if Global.pause and inventory_menu.visible:
		inventory_menu.hide()
		inventory_menu.close()
		Engine.time_scale = 1
		Global.pause = false
	elif not Global.pause and not inventory_menu.visible:
		inventory_menu.show()
		inventory_menu.open(Player)
		Engine.time_scale = 0
		Global.pause = true
