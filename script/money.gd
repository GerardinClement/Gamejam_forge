extends Area2D

var value
var goldAmount

func _ready():
	$goldAmount.play(goldAmount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		body.money += value
		queue_free()
