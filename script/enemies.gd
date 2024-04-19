extends CharacterBody2D

var enemy = name

func _ready():
	var statEnemy = Global.ennemies[name]
	var ray = RayCast2D.new()
	ray.set_collision_mask_value(4, true)
	ray.set_collision_mask_value(1, false)
	add_child(ray)
	
	enemy = Enemy.new()
	enemy.damage = statEnemy.damage
	enemy.speed = statEnemy.speed
	enemy.shootFrame = statEnemy.shootFrame
	enemy.bulletSpeed = statEnemy.bulletSpeed
	enemy.bulletPath = load("res://AnimatedCharacters/Enemies/" + self.name + "/Bullet.tscn")
	enemy.animations = $animations
	enemy.timer = $Timer
	enemy.ray = ray
	enemy.ray_pos = ColorRect.new()
	
func _physics_process(delta):
	enemy.process(delta, self)
	
func _process(delta):
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
