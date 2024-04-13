extends CharacterBody2D


const SPEED = 100.0
const bulletPath = preload("res://bullet.tscn")
@onready var animation = $AnimatedSprite2D

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
	
func _physics_process(delta):
	var mouseOffset = get_viewport().get_mouse_position() - self.position;
	var direction = mouseOffset.normalized() * SPEED
	if mouseOffset.x < 5 and mouseOffset.x > -5:
		animation.play("idle")
		return
	if direction.x > 0:
		animation.flip_h = false
		animation.play("run")
	else:
		animation.flip_h = true
		animation.play("run")
	velocity = direction * delta * SPEED
	move_and_slide()
	
func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Marker2D.global_position
