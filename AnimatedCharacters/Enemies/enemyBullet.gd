class_name EnemyBullet

extends Area2D

var speed
var damage
var bulletPath
var isShot = false
var velocity = Vector2()
@onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if bulletPath:
		if !isShot:
			var bulletSprite = bulletPath.instantiate()
			add_child(bulletSprite)
			bulletSprite.get_node("AnimatedSprite2D").play("default")
			look_at(player.global_position)
			velocity = bulletSprite.global_position.direction_to(player.global_position)
			isShot = true
		global_position += velocity * speed * delta
