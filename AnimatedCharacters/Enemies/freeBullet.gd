extends Area2D

@onready var animations = get_node("AnimatedSprite2D") 
var isDestroyed = false

func _on_body_entered(body):
	animations.play("destroy")
	if get_parent().velocity.x < 0:
		animations.flip_h = false
	else:
		animations.flip_h = true
	get_parent().velocity = Vector2(0,0)
	isDestroyed = true

func _on_animated_sprite_2d_animation_finished():
	if animations.animation == "destroy":
		get_parent().queue_free()
