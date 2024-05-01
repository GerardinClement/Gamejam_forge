extends Area2D

var rng = RandomNumberGenerator.new()
var value = 0
var goldAmount = 0

func _ready():
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	if value != 0:
		$Gold.play(goldAmount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func catch():
	Global.player.money += rng.randi_range(1, 10)
	$CollisionShape2D.disabled = true
	$GoldSound.play()
	$Gold.modulate.a = 0
	$Timer.start()
	
func _on_body_entered(body):
	if body.name == "Player":
		call_deferred("catch")
		
func _on_Timer_timeout():
	queue_free()
	

