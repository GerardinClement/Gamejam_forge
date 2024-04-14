extends CharacterBody2D
const bulletPath = preload("res://bullet.tscn")

@onready var animation = $AnimatedSprite2D
@onready var player_animation =  $AnimationPlayer
var player: Player

class Player:

	var stats: Dictionary
		
	func _init():
		stats = {
			"pv" : 100,
			"speed": 75,
			"attack_speed" : 4,
			"strength": 25,
		}
		
	func take_damage(bullet):
		self.stats["pv"] -= 33
		if self.stats["pv"] <= 0:
			self.player_death()
		bullet.queue_free()

	func player_death():
		pass

func _ready():
	player = Player.new()
	$Timer.start()
	
func _process(delta):
	$Node2D.look_at(get_global_mouse_position())
	if $Timer.is_stopped():
		animation.play("shoot")
		shoot()
		$Timer.start()
	
func _physics_process(delta):
	var mouseOffset = get_global_mouse_position() - self.position;
	var direction = mouseOffset.normalized() * player.stats["speed"]
	if mouseOffset.x < 5 and mouseOffset.x > -5:
		animation.play("idle")
		return
	if direction.x > 0:
		animation.flip_h = false
	else:
		animation.flip_h = true
	if !animation.is_playing() or animation.animation == "run" or animation.animation == "idle" :
		animation.play("run")
	velocity = direction * delta * player.stats["speed"]
	move_and_slide()
	
func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	if animation.flip_h == false:
		bullet.velocity.x = 1
	else:
		bullet.velocity.x = -1
		

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "bullet_enemy":
		player.take_damage(area.get_parent())
		player_animation.play("damage")
		
	
