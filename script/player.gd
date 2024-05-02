extends CharacterBody2D
const bulletPath = preload("res://Scene/bullet.tscn")

@onready var animation = $AnimatedSprite2D
@onready var playerAnimation =  $AnimatedSprite2D/AnimationPlayer
@onready var Card = "res://Cards.gd"
@onready var gui = $Camera2D/GUI
@onready var guided_missile = preload("res://Scene/guided_missile.tscn")
const scent_scene = preload("res://Scene/scent.tscn")
var player: Player
var isPause

class Player:
	var cards: Dictionary
	var shootSide: Dictionary
	var pv: float
	var pv_max: float
	var shield: int
	var speed: int
	var attack_speed: int
	var strength: int
	var money:int
	var pieces_of_cards:int
	var playerAnimation
	var gui
	var iframes
	var scent_trail = []
		
	func _init(playerAnimation, gui, timerIframe):
		pv = 6
		pv_max = 6
		speed = 150
		attack_speed = 2
		strength = 50
		shield = 1
		money = 10
		pieces_of_cards = 100
		shootSide = {
			"forward": true,
			"back": false,
			"top": false,
			"bottom": false,
			"topBack": false,
			"topForward": false,
			"bottomBack": false,
			"bottomForward": false,
		}
		self.playerAnimation = playerAnimation
		self.gui = gui
		self.iframes = timerIframe
	
	func add_card(newCard):
		if count_number_of_card() == 6:
			return 
		newCard.applyEffects(self)
		if not cards.has(newCard.name):
			cards[newCard.name] = [newCard]
		else:
			cards[newCard.name].append(newCard)
		gui.display_life(self)
		
	func take_damage(bullet):
		if !iframes.is_stopped():
			return 
		if self.shield > 0:
			self.shield -= 1
		else:
			self.pv -= bullet.damage
		playerAnimation.play("damage")
		gui.display_life(self)
		iframes.start()

	func player_death(animatedSprite):
		if animatedSprite.animation == "death":
			return
	
		Global.playerIsDead = true
		animatedSprite.play("death")
		
	func shoot(parent, marker2d, lookLeft, direction):
		for side in shootSide:
			if shootSide[side]:
				self.bulletDirection(parent, marker2d, lookLeft, side, direction)
				
	func bulletDirection(parent, marker2d, lookLeft, side, direction):
		var rotate = 0
		match side:
			"forward":
				createBulletInstance(parent, marker2d, direction, rotate)
			"back":
				direction.x = -direction.x
				createBulletInstance(parent, marker2d, direction, rotate)
			"top":
				direction = Vector2(0, -1)
				rotate = 90
				createBulletInstance(parent, marker2d, direction, rotate)
			"bottom":
				rotate = 90
				direction = Vector2(0, 1)
				createBulletInstance(parent, marker2d, direction, rotate)
			"topBack":
				rotate = 45
				if direction.x < 0:
					rotate = -45
				direction = Vector2(-direction.x, -1)
				createBulletInstance(parent, marker2d, direction, rotate)
			"topForward":
				rotate = 135
				if direction.x < 0:
					rotate = -135
				direction = Vector2(direction.x, -1)
				createBulletInstance(parent, marker2d, direction, rotate)
			"bottomBack":
				rotate = 45
				if direction.x > 0:
					rotate = -45
				direction = Vector2(-direction.x, 1)
				createBulletInstance(parent, marker2d, direction, rotate)
			"bottomForward":
				rotate = 135
				if direction.x > 0:
					rotate = -135
				direction = Vector2(direction.x, 1)
				createBulletInstance(parent, marker2d, direction, rotate)
		
				
	func createBulletInstance(parent, marker2d, direction, angleRotate):
		var bullet = bulletPath.instantiate()
		parent.add_child(bullet)
		bullet.position = marker2d.global_position
		bullet.velocity = direction
		#bullet.look_at(get_global_mouse_position())
		
	func remove_card(card):
		card.remove_effects(self)
		self.cards.erase(card.name)
		
	func count_number_of_card():
		var count = 0
		for cardsArray in self.cards.values():
			for card in cardsArray:
				count += 1
		return count


func _ready():
	isPause = false
	if not Global.gameIsStart:
		player = Player.new(playerAnimation, gui, $IFrames)
		Global.player = player
		$Shoot.wait_time = player.attack_speed
		$Shoot.start()
	else:
		player = Global.player
		player.playerAnimation = playerAnimation
		player.gui = gui
		player.iframes = $IFrames
	gui.display_life(player)
	gui.display_cards()
	
func _process(_delta):
	player = Global.player
	if player.pv <= 0:
		player.player_death(animation)
	setGlobal()
	if Global.pause != isPause and !Global.pause:
		$Shoot.start()
	if $Shoot.is_stopped() and !Global.pause:
		shoot()
	isPause = Global.pause

func _physics_process(_delta):
	if player.pv <= 0:
		return
	if !Global.pause:
		move(_delta)
	else:
		animation.play("idle")
		
func setGlobal():
	Global.playerPos = self.position
	Global.player = player
	
func shoot():
	if animation.animation == "death" || Global.playerIsInForge:
		return
		
	animation.play("shoot")
	$LaserSound.play()
	var mouseOffset = get_global_mouse_position() - self.position;
	var direction = mouseOffset.normalized() * player.speed
	var bullet = bulletPath.instantiate()
	bullet.position = $Node2D/Marker2D.global_position
	bullet.velocity = direction
	bullet.look_at(get_global_mouse_position())
	self.get_parent().add_child(bullet)
	if player.attack_speed > 0:
		$Shoot.wait_time = player.attack_speed
	$Shoot.start()

func get_direction():
	var direction = Vector2(0, 0)
	
	if Input.is_action_pressed("Right"):
		direction.x += 1
	if Input.is_action_pressed("Left"):
		direction.x -= 1
	if Input.is_action_pressed("Down"):
		direction.y += 1
	if Input.is_action_pressed("Up"):
		direction.y -= 1
	if direction.length() > 0:
		direction = direction.normalized()
	return direction
		
func flip_sprite(direction):
	if direction.x > 0:
		animation.flip_h = false
	else:
		animation.flip_h = true
		
func play_animation(direction):
	if animation.animation == "shoot" and animation.is_playing():
		return
	if direction == Vector2(0, 0):
		animation.play("idle")
	else:
		animation.play("run")
	
func move(_delta):
	var direction = get_direction()
	flip_sprite(direction)
	play_animation(direction)
	velocity = direction * player.speed
	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "death":
		get_tree().change_scene_to_file("res://Scene/GameOver.tscn")
	
func add_scent():
	var scent = scent_scene.instantiate()
	scent.player = player
	scent.position = position
	
	get_parent().add_child(scent)
	player.scent_trail.push_front(scent)

