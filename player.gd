extends CharacterBody2D


const SPEED = 75.0
var PV = 100
const bulletPath = preload("res://bullet.tscn")
@onready var animation = $AnimatedSprite2D

func _ready():
	$Timer.start()
	
func _process(delta):
	$Node2D.look_at(get_global_mouse_position())
	if $Timer.is_stopped():
		animation.play("shoot")
		shoot()
		$Timer.start()
	if PV <= 0:
		player_death()
	
func _physics_process(delta):
	var mouseOffset = get_global_mouse_position() - self.position;
	var direction = mouseOffset.normalized() * SPEED
	if mouseOffset.x < 5 and mouseOffset.x > -5:
		animation.play("idle")
		return
	if direction.x > 0:
		animation.flip_h = false
	else:
		animation.flip_h = true
	if !animation.is_playing() or animation.animation == "run" or animation.animation == "idle" :
		animation.play("run")
	velocity = direction * delta * SPEED
	move_and_slide()
	
func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	if animation.flip_h == false:
		bullet.velocity.x = 1
	else:
		bullet.velocity.x = -1
		

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "bullet_enemy":
		take_damage(area.get_parent())
		
func take_damage(bullet):
	PV -= 33
	bullet.queue_free()
	
func player_death():
	print("player is dead")
	
	
