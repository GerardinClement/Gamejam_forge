extends CharacterBody2D


const SPEED = 100.0
var mouse_position = null
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	
	var direction = (mouse_position - position)
	velocity = direction * delta * SPEED
	#if direction:
		##if direction == -1:
			##animated_sprite.flip_h = true
		##else:
			##animated_sprite.flip_h = false
		#animated_sprite.play("run")
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#animated_sprite.play("idle")
	move_and_slide()
