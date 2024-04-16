extends CharacterBody2D

var mech

func _ready():
	mech = Enemy.new()
	mech.damage = 10
	mech.speed = 20
	mech.shootFrame = 3
	mech.bulletSpeed = 200.0
	mech.bulletPath = preload("res://AnimatedCharacters/Enemies/mech/Bullet.tscn")
	mech.animations = $animations
	mech.timer = $Timer
	mech.ray = $RayCast2D
	
func _physics_process(_delta):
	mech.process(_delta, self)
	
func _process(_delta):
	mech.play_shoot_animations()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		mech.canShoot = true

func _on_area_2d_body_exited(body):
	if body.name == 'Player':
		mech.canShoot = false
		mech.resetAnimation()
