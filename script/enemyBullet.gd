class_name EnemyBullet

extends Area2D

var speed
var damage
var bulletPath
var velocity = Vector2()
var isDestroyed = false
@onready var parent = get_parent()
@onready var animations = $AnimatedSprite2D

func _ready():
	self.damage = parent.enemy.damage
	self.speed = parent.enemy.bulletSpeed
	self.bulletPath = parent.enemy.bulletPath
	self.get_node("AnimatedSprite2D").play("default")
	look_at(Global.playerPos)
	var direction = self.global_position.direction_to(Global.playerPos)
	velocity = direction.normalized() * speed
	
func _physics_process(delta):
	if !bulletPath:
		return
	self.position += self.velocity * delta

func _on_body_entered(_body):
	if _body.name == "Player":
		_body.player.take_damage(self)
	if self.velocity.x < 0:
		animations.flip_h = false
	else:
		animations.flip_h = true
	self.velocity = Vector2(0,0)
	isDestroyed = true
	animations.play("destroy")
	
func _on_animated_sprite_2d_animation_finished():
	if animations.animation == "destroy":
		self.queue_free()
