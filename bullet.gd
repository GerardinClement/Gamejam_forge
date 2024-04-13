extends CharacterBody2D

const SPEED = 300.0

@onready var animated_sprite = $AnimatedSprite2D
func _physics_process(delta):
	animated_sprite.play("default")
	move_and_collide(velocity.normalized() * delta * SPEED)

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "enemy":
		area.get_parent().queue_free()
	self.queue_free()
