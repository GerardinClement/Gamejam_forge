class_name Enemy

extends CharacterBody2D

var animations
var timer
var speed
var ray
var bulletSpeed
var damage
var shootFrame
var enemyDir
var bulletPath
var canShoot = false
var hasShot = true

func play_shoot_animations():
	if timer.is_stopped() && canShoot && !checkWalls():
		hasShot = false
		if position.x < Global.playerPos.x:
			animations.set_flip_h(false)
		else:
			animations.set_flip_h(true)
		animations.play("shootRight")
		timer.start()

func process(delta, parent):
	if checkFrame() && !hasShot && !checkWalls():
		hasShot = true
		shoot(parent)
	chase_player()
	velocity = global_position.direction_to(enemyDir)
	if animations.is_playing && animations.animation != "moveRight" && animations.animation != "idle" && self.position.distance_to(Global.playerPos) < 200:
		return
	move(delta, parent)

func chase_player():
	ray.target_position = Global.playerPos
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		print("No collision")
		enemyDir = ray.target_position
	
	else:
		print("Collision")
		for scent in Global.player.scent_trail:
			ray.target_position = scent.position
			ray.force_raycast_update()
			if !ray.is_colliding():
				print("Scent pos : ", scent.position)
				enemyDir = ray.target_position
				break

func move(delta, parent):
	if enemyDir.x > position.x:
		animations.set_flip_h(false)
	else:
		animations.set_flip_h(true)
	animations.play("moveRight")
	parent.move_and_collide(velocity * speed * delta)

func shoot(parent):
	var bullet = bulletPath.instantiate()

	if animations.is_flipped_h() == false:
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
		animations.play("moveRight")

func checkWalls():
	ray.target_position = Global.playerPos
	if ray.get_collider():
		resetAnimation()
		return true
	return false
