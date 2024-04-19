extends Node2D

@onready var animation_victory = $PlayerAnimation
@onready var background = $Background
@onready var npc_animation = $NPCAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	background.modulate.a = 0.5
	animation_victory.play("animation_victory")
	npc_animation.play("npc_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")
