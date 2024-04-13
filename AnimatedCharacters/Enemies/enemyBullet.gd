extends CharacterBody2D

@onready var player = get_parent().get_parent().get_node("Player")
const speed = 3000


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = global_position.direction_to(player.global_position)
	move_and_collide(velocity * speed * delta)
