extends StaticBody2D

@onready var animation = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detector_body_entered(body):
	if body.name == "Player":
		animation.play("large_door_opening")


func _on_player_detector_body_exited(body):
	if body.name == "Player":
		animation.play("large_door_closing")
