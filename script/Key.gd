extends Area2D

@onready var animation_key = $KeyAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_key.play("key_anim")
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	$KeySound.play()
	$KeyAnimation.modulate.a = 0
	$Timer.start()
	
func _on_Timer_timeout():
	Global.playerKeys += 1
	queue_free()
