extends Control

@onready var animation_mecha = $Mecha
@onready var animation_background = $Background
@onready var animation_mecha_death = $MechaDeath
@onready var animation_targets = $Targets

func _ready():
	animation_mecha.play("mecha_animation")
	animation_mecha.flip_h = true
	animation_background.play("background_animation")
	animation_targets.play("target")
	for child in $Targets.get_children():
		child.play()
	
	animation_background.modulate.a = 0.75
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	
func _process(delta):
	pass

func _on_start_button_pressed():
	animation_mecha.modulate.a = 0
	animation_mecha_death.play("mecha_death")
	animation_mecha_death.flip_h = true
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://Controls.tscn")

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Credits.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

