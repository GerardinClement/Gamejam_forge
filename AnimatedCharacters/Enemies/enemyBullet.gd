extends Area2D

#@onready var player = get_parent().get_parent().get_node("Player")
const speed = 300.0
var isReady = false
var velocity = Vector2()
@onready var player = get_parent().get_node("Player")

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$AnimatedSprite2D.play("default")
	if !isReady:
		look_at(player.global_position)
		velocity = position.direction_to(player.global_position)
		isReady =  true
	position += velocity * speed * delta

func _on_body_entered(body):
	queue_free()
