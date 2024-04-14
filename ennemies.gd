extends CharacterBody2D


@export var speed = 60
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
		if enemyPos.x < playerPos.x:
			animations.play("shootRight")
		else:
			animations.play("shootLeft")
		$Timer.set_wait_time(1)
		$Timer.start()
		
	if checkFrame() && !hasShot:
		shoot()
		hasShot = true

func _physics_process(delta):
	#if animations.is_playing() && (animations.animation != "moveRight" || animations.amination != "moveLeft"):
	#	return
	playerPos = player.position
	enemyPos = (playerPos - position).normalized()
	velocity = global_position.direction_to(player.global_position)
	if enemyPos.x > 0 && !animations.is_playing():
		animations.play("moveRight")
	elif !animations.is_playing():
		animations.play("moveLeft")
	move_and_collide(velocity * speed * delta)
	if global_position.distance_to(player.global_position) > 200:
		canShoot = false
	elif !canShoot:
		shoot()
		canShoot = true
		$Timer.start()


func shoot():
	getBulletPath()
	if bulletPath:
		var bullet = bulletPath.instantiate()
		get_parent().add_child(bullet)
		bullet.position = get_node("gunPos").global_position

func getBulletPath():
	if get_name() == 'octopus':
		bulletPath = load("res://AnimatedCharacters/Enemies/octopus/Bullet.tscn")
	elif get_name() == 'mech':
		bulletPath = load("res://AnimatedCharacters/Enemies/mech/Bullet.tscn")
	elif get_name() == 'human':
		bulletPath = load("res://AnimatedCharacters/Enemies/human/Bullet.tscn")
		
func checkFrame():
	if get_name() == 'octopus' && animations.frame == 2:
		return true
	elif get_name() == 'mech' && animations.frame == 3:
		return true
	elif get_name() == 'human' && animations.frame == 1:
		return true
	return false
