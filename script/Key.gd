extends Area2D

@onready var animation_key = $KeyAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_key.play("key_anim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	Global.playerKeys += 1
	queue_free()
