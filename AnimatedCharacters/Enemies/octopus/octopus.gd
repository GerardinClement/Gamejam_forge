extends CharacterBody2D

var octopus

func _ready():
	octopus = Enemy.new()
	octopus.damage = 5
	octopus.speed = 35
	octopus.shootFrame = 2
	octopus.bulletSpeed = 250.0
	octopus.bulletPath = load("res://AnimatedCharacters/Enemies/octopus/Bullet.tscn")
	add_child(octopus)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		octopus.canShoot = true

func _on_area_2d_body_exited(body):
	if body.name == 'Player':
		octopus.canShoot = false
		octopus.resetAnimation()
