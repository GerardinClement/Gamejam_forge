extends CharacterBody2D

var human

func _ready():
	human = Enemy.new()
	human.damage = 2
	human.speed = 30
	human.shootFrame = 1
	human.bulletPath = load("res://AnimatedCharacters/Enemies/human/Bullet.tscn")
	add_child(human)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		human.canShoot = true

func _on_area_2d_body_exited(body):
	if body.name == 'Player':
		human.canShoot = false
		human.resetAnimation()
