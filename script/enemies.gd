extends CharacterBody2D

var enemy = self.name

func _ready():
	var statEnemy = Global.ennemies[self.name]
	enemy = Enemy.new()
	enemy.damage = statEnemy.damage
	enemy.speed = statEnemy.speed
	enemy.shootFrame = statEnemy.shootFrame
	enemy.bulletSpeed = statEnemy.bulletSpeed
	enemy.bulletPath = load("res://AnimatedCharacters/Enemies/" + self.name + "/Bullet.tscn")
	enemy.animations = $animations
	enemy.timer = $Timer
	enemy.ray = $RayCast2D
	
func _physics_process(_delta):
	enemy.process(_delta, self)
	
func _process(_delta):
	enemy.play_shoot_animations()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		enemy.canShoot = true

func _on_area_2d_body_exited(body):
	if body.name == 'Player':
		enemy.canShoot = false
		enemy.resetAnimation()
		
func chooseRandomEnemy():
	var ennemies = Global.ennemies.keys()
	var enemy = ennemies[randi() % ennemies.size()]
	return Global.ennemies[enemy]
