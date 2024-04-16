class_name EnemyBullet

extends Area2D

var speed
var damage
var bulletPath
var isShot = false
var velocity = Vector2()
var isDestroyed = false
@onready var parent = get_parent()
@onready var animations = $AnimatedSprite2D

func _ready():
	self.damage = parent.mech.damage
	self.speed = parent.mech.speed
	self.bulletPath = parent.mech.bulletPath
	
func _physics_process(delta):
	if bulletPath:
		if !isShot:
			self.get_node("AnimatedSprite2D").play("default")
			look_at(Global.playerPos)
			velocity = self.global_position.direction_to(Global.playerPos)
			isShot = true
		self.global_position += velocity * speed * delta


func _on_body_entered(_body):
	print(_body.name)
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
