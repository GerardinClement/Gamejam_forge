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

func process(delta, parent):
	if checkFrame() && !hasShot && !checkWalls():
		hasShot = true
		shoot(parent)
	
	chase_player(parent)
	if animations.is_playing && animations.animation != "moveRight" && animations.animation != "idle" && self.position.distance_to(Global.playerPos) < 200:
		return
	move(delta, parent)

func chase_player(parent):
	ray.position = parent.position
	ray_pos.position = ray.position
	ray.target_position = Global.playerPos
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		enemyDir = ray.target_position
		ray_target.position = enemyDir
	
	else:
		for scent in Global.player.scent_trail:
			ray.target_position = scent.position
			ray.force_raycast_update()
			if !ray.is_colliding():
				enemyDir = ray.target_position
				ray_target.position = enemyDir
				break
	
	if enemyDir != Vector2():
		velocity = parent.position.direction_to(enemyDir)

func move(delta, parent):
	if enemyDir.x > parent.global_position.x:
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
