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
var health
var canShoot = false
var hasShot = true

func play_shoot_animations(parent):
	if health <= 0:
		return

	if timer.is_stopped() && canShoot && !checkWalls(parent) && animations.animation != "hit":
		hasShot = false
		if parent.position.x < Global.playerPos.x:
			animations.set_flip_h(false)
		else:
			animations.set_flip_h(true)
		animations.play("shootRight")
		timer.start()
	
	if checkFrame() && !hasShot:
		hasShot = true
		shoot(parent)

func process(delta, parent):
	if animations.is_playing && animations.animation != "moveRight" && animations.animation != "idle" && parent.position.distance_to(Global.playerPos) < 200:
		return
	
	if health <= 0 || animations.animation == "hit":
		return
	
	chase_player(parent)
	move(delta, parent)

func chase_player(parent):
	enemyDir = Vector2()
	ray.position = position
	ray.target_position = parent.to_local(Global.playerPos)
	ray.force_raycast_update()

	if !ray.is_colliding():
		enemyDir = to_local(Global.playerPos)
	elif Global.playerIsInForge:
		for scent in Global.player.scent_trail:
			ray.target_position = parent.to_local(scent.position)
			ray.force_raycast_update()
			if !ray.is_colliding():
				enemyDir = to_local(scent.position)
				break

func move(delta, parent):
	if enemyDir == Vector2():
		animations.play("idle")
		return

	velocity = parent.position.direction_to(enemyDir)

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
	if animations.animation == "shootRight" && animations.frame == shootFrame:
		return true
	return false

func resetAnimation():
	if animations.is_playing() && animations.animation == 'shootRight':
		animations.stop()
		animations.play("idle")

func checkWalls(parent):
	ray.target_position = parent.to_local(Global.playerPos)
	ray.force_raycast_update()
	if ray.get_collider():
		resetAnimation()
		return true
	return false

func check_death(parent):
	if health > 0:
		return

	animations.play("death")

func takeDamage():
	health -= Global.player.strength
	animations.play("hit")
