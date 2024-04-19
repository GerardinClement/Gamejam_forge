extends CharacterBody2D

const SPEED = 300.0

@onready var animated_sprite = $AnimatedSprite2D

func ready():
	animated_sprite.play("default")

func _physics_process(_delta):
	if !animated_sprite.is_playing():
		animated_sprite.play("default")
	move_and_collide(velocity.normalized() * _delta * SPEED)

func _on_area_2d_body_entered(body):
	if body.name != "TileMap":
		body.enemy.takeDamage()
	destroy_itself()
	
func destroy_itself():
	animated_sprite.play("impact")
	if velocity.x < 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "impact":
		self.queue_free()
