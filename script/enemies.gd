extends CharacterBody2D

var enemy = name
const moneyPath = preload("res://money.tscn")

func _ready():
	var newName = checkName(name)
	var statEnemy = Global.ennemies[newName]
	var ray = RayCast2D.new()
	ray.set_collision_mask_value(4, true)
	ray.set_collision_mask_value(1, false)
	add_child(ray)
	
	enemy = Enemy.new()
	enemy.health = statEnemy.health
	enemy.damage = statEnemy.damage
	enemy.speed = statEnemy.speed
	enemy.shootFrame = statEnemy.shootFrame
	enemy.bulletSpeed = statEnemy.bulletSpeed
	enemy.bulletPath = load("res://AnimatedCharacters/Enemies/" + newName + "/Bullet.tscn")
	enemy.animations = $animations
	enemy.timer = $Timer
	enemy.ray = ray
	enemy.animations.play("idle")
	
func _physics_process(delta):
	enemy.process(delta, self)
	
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
		dropMoney()
		queue_free()

	elif $animations.animation == "hit":
		$animations.play("moveRight")

func dropMoney():
	var newName = checkName(name)
	var statEnemy = Global.ennemies[newName]
	var moneyDroped = moneyPath.instantiate()
	
	moneyDroped.goldAmount = statEnemy.goldAmount
	moneyDroped.value = statEnemy.goldValue
	moneyDroped.position = position
	get_parent().add_child(moneyDroped)

func checkName(oldName: String):
	var newName = ""

	for c in oldName:
		if c >= "0" && c <= "9":
			continue
		else:
			newName += c
	
	return newName
