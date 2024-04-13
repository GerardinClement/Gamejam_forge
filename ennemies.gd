extends CharacterBody2D


@export var speed = 100
@onready var player = get_parent().get_node("Player")
var playerPos
var enemyPos
var bulletPath

func _physics_process(delta):
	var animations = get_node("animations")
	playerPos = player.position
	enemyPos = (playerPos - position).normalized()
	velocity = global_position.direction_to(player.global_position)
	if enemyPos.x > 0:
		animations.play("moveRight")
	else:
		animations.play("moveLeft")
	move_and_collide(velocity * speed * delta)
	shoot()

func shoot():
	getBulletPath()
	print(bulletPath)
	if bulletPath:
		var bullet = bulletPath.instantiate()
		add_child(bullet)

func getBulletPath():
	if get_name() == 'octopus':
		bulletPath = load("res://AnimatedCharacters/Enemies/octopus/Bullet.tscn")
		
