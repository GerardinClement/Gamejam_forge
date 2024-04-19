extends CharacterBody2D

var enemy = self.name

func _ready():
	var statEnemy = Global.ennemies[self.name]
	enemy = Enemy.new()
	enemy.health = statEnemy.health
	enemy.damage = statEnemy.damage
	enemy.speed = statEnemy.speed
	enemy.shootFrame = statEnemy.shootFrame
	enemy.bulletSpeed = statEnemy.bulletSpeed
	enemy.bulletPath = load("res://AnimatedCharacters/Enemies/" + self.name + "/Bullet.tscn")
	enemy.animations = $animations
	enemy.timer = $Timer
	enemy.ray = ray
	
func _physics_process(_delta):
	enemy.process(_delta, self)
	
func _process(delta):
	enemy.check_death(self)
	enemy.play_shoot_animations(self)

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

func _on_animations_animation_finished():
	if $animations.animation == "death":
		queue_free()
