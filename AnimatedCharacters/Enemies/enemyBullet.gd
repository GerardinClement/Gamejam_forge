class_name EnemyBullet

extends Area2D

var speed
var damage
var bulletPath
var isReady = false
var velocity = Vector2()
@onready var player = get_parent().get_node("Player")

func _ready():
	pass

func _physics_process(delta):
	if bulletPath:
		var bulletSprite = bulletPath.instantiate()
		add_child(bulletSprite)
		bulletSprite.get_node("AnimatedSprite2D").play("default")
		if !isReady:
			look_at(player.global_position)
			velocity = bulletSprite.global_position.direction_to(player.global_position)
			isReady = true
		global_position += velocity * speed * delta
