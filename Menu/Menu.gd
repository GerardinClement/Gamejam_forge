extends Control

@onready var animation_mecha = $Mecha

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_mecha.play("mecha_animation")
	animation_mecha.flip_h = true
	
# Called every frame. 'delta' is animation_mechathe elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
