extends Control

@onready var animation_mecha = $Mecha
@onready var animation_background = $Background
@onready var animation_mecha_death = $MechaDeath
@onready var animation_targets = $Targets

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_mecha.play("mecha_animation")
	animation_mecha.flip_h = true
	animation_background.play("background_animation")
	animation_targets.play("target")
	for child in $Targets.get_children():
		child.play()
	
	animation_background.modulate.a = 0.75
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	
# Called every frame. 'delta' is animation_mechathe elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	animation_mecha.modulate.a = 0
	animation_mecha_death.play("mecha_death")
	animation_mecha_death.flip_h = true
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_quit_button_pressed():
	get_tree().quit()


# Assuming you have an AnimationPlayer node named "AnimationPlayer"
# and a Button node named "StartButton"
#
#func _ready():
	## Connect the button's pressed signal to a function
	#
#
#func _on_StartButton_pressed():
	## Play the new animation when the start button is pressed
	#$AnimationPlayer.play("NewAnimationName")
