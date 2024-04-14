extends CharacterBody2D


@export var speed = 30
@onready var player = get_parent().get_node("Player")
var hasShot = true
var canShoot = false
var animations
var playerPos
var enemyPos
var bulletPath

func _ready():
	animations = get_node("animations")

func _process(delta):
	if $Timer.is_stopped() && canShoot:
		hasShot = false
		if position.x < player.position.x:
			animations.set_flip_h(false)
		else:
			animations.set_flip_h(true)
		animations.play("shootRight")
		$Timer.start()

func _physics_process(delta):
	if checkFrame() && !hasShot:
		hasShot = true
		shoot()
	playerPos = player.position
	enemyPos = (playerPos - position).normalized()
	velocity = global_position.direction_to(player.global_position)
	if animations.is_playing && animations.animation != "moveRight" && animations.animation != "idle" && global_position.distance_to(player.global_position) < 200:
		return
	move(delta)

func move(delta):
	if position.x < player.position.x:
		animations.set_flip_h(false)
	else:
		animations.set_flip_h(true)
	animations.play("moveRight")
	move_and_collide(velocity * speed * delta)

func shoot():
	checkWalls()
	getBulletPath()
	if bulletPath:
		var bullet = bulletPath.instantiate()
		get_parent().add_child(bullet)
		setDamage(bullet)
		if animations.is_flipped_h() == false:
			bullet.position = get_node("rightSide").global_position
		else:
			bullet.position = get_node("leftSide").global_position

func getBulletPath():
	if get_name() == 'octopus':
		bulletPath = load("res://AnimatedCharacters/Enemies/octopus/Bullet.tscn")
	elif get_name() == 'mech':
		bulletPath = load("res://AnimatedCharacters/Enemies/mech/Bullet.tscn")
	elif get_name() == 'human':
		bulletPath = load("res://AnimatedCharacters/Enemies/human/Bullet.tscn")
		
func checkFrame():
	if name == 'octopus' && animations.frame == 2:
		return true
	elif name == 'mech' && animations.frame == 3:
		return true
	elif name == 'human' && animations.frame == 1:
		return true
	return false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		canShoot = true

func _on_area_2d_body_exited(body):
	if body.name == 'Player':
		canShoot = false
	if animations.is_playing() && animations.animation == 'shootRight':
		animations.stop()
		animations.play("moveRight")

func setDamage(bullet):
	if name == 'mech':
		bullet.damage = 10
	elif name == 'human':
		bullet.damage = 2
	else:
		bullet.damage = 5

func checkWalls():
	var ray = $RayCast2D
	if !animations.is_flipped_h():
		ray.position = get_node("rightSide").global_position
	else:
		ray.position = get_node("leftSide").global_position
	ray.target_position = player.global_position
	print(ray.target_position)
