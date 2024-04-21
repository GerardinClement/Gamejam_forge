extends Control

@onready var animation_key = $Key

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_key.play("key_anim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
