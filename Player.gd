extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		animated_sprite.play("run")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.stop()

	move_and_slide()
