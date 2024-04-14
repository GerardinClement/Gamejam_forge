extends CharacterBody2D

#@onready var player = get_parent().get_parent().get_node("Player")
const speed = 300.0
@onready var player = get_parent().get_node("Player")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if $AnimatedSprite2D:
		$AnimatedSprite2D.play("default")
	if velocity == Vector2(0, 0):
		velocity = position.direction_to(player.global_position)
		look_at(player.global_position)
	move_and_collide(velocity.normalized() * speed * delta)
