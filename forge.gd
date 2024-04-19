extends Node2D

@onready var animation_go_to_forge = $GoToMap/Animation

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_go_to_forge.play("go_to_forge_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
