extends Node2D
@onready var invetory_menu = $Player/Camera2D/InventoryMenu
@onready var Player = $Player.player
var pause = true


# Called when the node enters the scene tree for the first time.
func _ready():
	var card_manager_scene = preload("res://cardsManager.tscn")
	var card_manager_instance = card_manager_scene.instantiate()
	add_child(card_manager_instance)
	await card_manager_instance
	invetory_menu.hide()
	
func _process(delta):
	if Input.is_action_just_pressed("Invetory"):
		pass
		invetoryMenu()
		
func invetoryMenu():
	if !pause:
		invetory_menu.hide()
		invetory_menu.close()
		Engine.time_scale = 1
		pause = true
	else:
		invetory_menu.show()
		invetory_menu.open(Player)
		Engine.time_scale = 0
		pause = false
