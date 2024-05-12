extends Node2D

@onready var animation_mecha = $Mecha

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_mecha.play("mecha_shoot")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_restart_button_pressed():
	Global.playerIsDead = false
	get_tree().change_scene_to_file("res://Scene/main.tscn")

func _on_back_to_menu_button_pressed():
	Global.playerIsDead = false
	get_tree().change_scene_to_file("res://Scene/Menu.tscn")
