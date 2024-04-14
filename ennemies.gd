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
	if $Timer.is_stopped() && global_position.distance_to(player.global_position) < 200:
		hasShot = false
		if position.x < player.position.x:
			animations.set_flip_h(false)
		else:
			animations.set_flip_h(true)
		animations.play("shootRight")
		$Timer.start()
		
	if checkFrame() && !hasShot && global_position.distance_to(player.global_position) < 200:
		hasShot = true
		print("here")
		shoot()

func _physics_process(delta):
	playerPos = player.position
	enemyPos = (playerPos - position).normalized()
	velocity = global_position.direction_to(player.global_position)
	if animations.is_playing && animations.animation != "moveRight" && animations.animation != "idle" && global_position.distance_to(player.global_position) < 200:
		print(animations.animation)
		return
	if position.x > 0:
		animations.set_flip_h(false)
	else:
		animations.set_flip_h(true)
	animations.play("moveRight")
	move_and_collide(velocity * speed * delta)


func shoot():
	getBulletPath()
	if bulletPath:
		var bullet = bulletPath.instantiate()
		get_parent().add_child(bullet)
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
	if get_name() == 'octopus' && animations.frame == 2:
		return true
	elif get_name() == 'mech' && animations.frame == 3:
		return true
	elif get_name() == 'human' && animations.frame == 1:
		return true
	return false
