extends CharacterBody2D

const SPEED = 300.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	animated_sprite.play("default")
	move_and_collide(velocity.normalized() * delta * SPEED)

func _on_area_2d_body_entered(body):
	self.queue_free()
