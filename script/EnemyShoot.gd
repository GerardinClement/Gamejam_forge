extends State
class_name EnemyShoot

@export var enemy: CharacterBody2D
var player: CharacterBody2D

func shoot():
	var bullet = enemy.bulletPath.instantiate()
	if enemy.animations.is_flipped_h() == true:
		bullet.position = enemy.get_node("leftSide").position
	else:
		bullet.position = enemy.get_node("rightSide").position
	enemy.bullet_instance = bullet
	enemy.timer.wait_time = enemy.stats.attack_speed
	
func enter():
	enemy.is_shooting = true
	player = get_tree().get_first_node_in_group("Player")
	enemy.animations.play("shoot")
	self.shoot()
	
func update(_delta):
	if not enemy.timer.is_stopped():
		if not enemy.player_in:
			Transitioned.emit(self, "Idle")
		else:
			Transitioned.emit(self, "Chase")
