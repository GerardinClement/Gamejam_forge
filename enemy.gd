class_name Enemy

extends CharacterBody2D

@onready var animations = get_parent().get_node("animations")
@onready var player = get_parent().get_parent().get_node("Player")
@onready var timer = get_parent().get_node("Timer")
var speed
var bulletSpeed
var damage
var shootFrame
var playerPos
var enemyPos 
var bulletPath
var canShoot = false
var hasShot = true

func _process(delta):
	if timer.is_stopped() && canShoot && !checkWalls():
		hasShot = false
		if global_position.x < player.global_position.x:
			animations.set_flip_h(false)
		else:
			animations.set_flip_h(true)
		animations.play("shootRight")
		timer.start()

func _physics_process(delta):
	if checkFrame() && !hasShot && !checkWalls():
		hasShot = true
		shoot()
	playerPos = player.global_position
	enemyPos = (playerPos - global_position).normalized()
	velocity = global_position.direction_to(player.global_position)
	if animations.is_playing && animations.animation != "moveRight" && animations.animation != "idle" && global_position.distance_to(player.global_position) < 200:
		return
	move(delta)

func move(delta):
	if global_position.x < player.global_position.x:
		animations.set_flip_h(false)
	else:
		animations.set_flip_h(true)
	animations.play("moveRight")
	get_parent().move_and_collide(velocity * speed * delta)

func shoot():
	var bullet = EnemyBullet.new()
	bullet.damage = damage
	bullet.speed = bulletSpeed
	bullet.bulletPath = bulletPath
	get_parent().get_parent().add_child(bullet)
	if animations.is_flipped_h() == false:
		bullet.position = get_parent().get_node("rightSide").global_position
	else:
		bullet.position = get_parent().get_node("leftSide").global_position

func checkFrame():
	if animations.frame == shootFrame:
		return true
	return false

func resetAnimation():
	if animations.is_playing() && animations.animation == 'shootRight':
		animations.stop()
		animations.play("moveRight")

func checkWalls():
	var ray = get_parent().get_node("RayCast2D")
	ray.target_position = player.global_position
	if ray.get_collider():
		resetAnimation()
		return true
	return false
