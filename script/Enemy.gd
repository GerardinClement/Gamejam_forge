class_name Enemy

extends CharacterBody2D

@onready var player = get_parent().get_parent().get_node("Player")
var animations
var timer
var speed
var ray
var bulletSpeed
var damage
var shootFrame
var enemyDir
var bulletPath
var ray_pos
var ray_target
var canShoot = false
var hasShot = true

func play_shoot_animations(parent):
	if timer.is_stopped() && canShoot && !checkWalls():
		hasShot = false
		if parent.position.x < Global.playerPos.x:
			animations.set_flip_h(false)
		else:
			animations.set_flip_h(true)
		animations.play("shootRight")
		timer.start()
		return

func process(delta, parent):
	if checkFrame() && !hasShot && !checkWalls():
		hasShot = true
		shoot(parent)
	
	if animations.is_playing && animations.animation != "moveRight" && animations.animation != "idle" && self.position.distance_to(Global.playerPos) < 200:
		return
	
	chase_player(parent)
	if enemyDir != Vector2():
		velocity = parent.position.direction_to(enemyDir)
		move(delta, parent)
	else:
		animations.play("idle")

func chase_player(parent):
	enemyDir = Vector2()
	ray.position = position
	ray.target_position = parent.to_local(Global.playerPos)
	ray.force_raycast_update()

	if !ray.is_colliding():
		enemyDir = to_local(Global.playerPos)
	
	else:
		print("Collision")
		for scent in Global.player.scent_trail:
			ray.target_position = parent.to_local(scent.position)
			ray.force_raycast_update()
			if !ray.is_colliding():
				enemyDir = to_local(scent.position)
				break

func move(delta, parent):
	if enemyDir.x > parent.position.x:
		animations.set_flip_h(false)
	else:
		animations.set_flip_h(true)
	animations.play("moveRight")
	parent.move_and_collide(velocity * speed * delta)

func shoot(parent):
	var bullet = bulletPath.instantiate()

	if animations.is_flipped_h() == true:
		bullet.position = parent.get_node("leftSide").position
	else:
		bullet.position = parent.get_node("rightSide").position
	parent.add_child(bullet)

func checkFrame():
	if animations.frame == shootFrame:
		return true
	return false

func resetAnimation():
	if animations.is_playing() && animations.animation == 'shootRight':
		animations.stop()
		animations.play("idle")

func checkWalls():
	ray.target_position = Global.playerPos
	ray.force_raycast_update()
	if ray.get_collider():
		resetAnimation()
		return true
	return false
