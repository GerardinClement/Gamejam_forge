extends Node2D
@onready var invetory_menu = $Player/Camera2D/InventoryMenu
var pause = true


# Called when the node enters the scene tree for the first time.
func _ready():
	invetory_menu.hide()
	
func _process(delta):
	if Input.is_action_just_pressed("Invetory"):
		pass
		invetoryMenu()
		
func invetoryMenu():
	if !pause:
		invetory_menu.hide()
		Engine.time_scale = 1
		pause = true
	else:
		invetory_menu.show()
		Engine.time_scale = 0
		pause = false
