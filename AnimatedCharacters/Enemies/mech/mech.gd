extends CharacterBody2D

var mech

func _ready():
	mech = Enemy.new()
	mech.damage = 10
	mech.speed = 20
	mech.shootFrame = 3
	mech.bulletSpeed = 200.0
	mech.bulletPath = load("res://AnimatedCharacters/Enemies/mech/Bullet.tscn")
	add_child(mech)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		mech.canShoot = true

func _on_area_2d_body_exited(body):
	if body.name == 'Player':
		mech.canShoot = false
		mech.resetAnimation()
