extends Node2D

var card
var onShop = false
var mouseOn = false
var isStored = false
var forChoose = false
var isSelected = false
var animationsFinished: Array
var dropableZoneName
var old_scale: Vector2

@onready var rectLabel = $Control
@onready var labelName = $Control/ColorRect/TextureRect/name
@onready var labelDescription = $Control/ColorRect/TextureRect2/description
@onready var labelLevel = $Control/ColorRect/level
@onready var labelEffects = $Control/ColorRect/TextureRect3/effects
@onready var animationPlayer = $Card/AnimationPlayer
@onready var animatesExplosions = $AnimatesExplosions
var initPos

func _ready():
	self.scale = Vector2(0.7, 0.7)
	rectLabel.visible = false
	self.input_pickable = true
	
func _process(delta):
	if not animationPlayer.is_playing() and not animatesExplosions.is_playing():
		if Input.is_action_just_pressed("click") and Global.playerIsInForge and mouseOn:
			get_tree().call_group("Forge", "add_to_dropable", self)
		elif Input.is_action_just_pressed("click") and self.card.type == "consumable":
			use_card()
		if Input.is_action_just_pressed("click") and forChoose and mouseOn:
			isSelected = true

func _on_mouse_entered():
	
	mouseOn = true
	rectLabel.visible = true
	labelName.text = card.name
	labelLevel.text = "Level: " + str(card.level)
	labelDescription.text = card.description
	labelEffects.text = ""
	if self.card.type == "consumable":
		labelEffects.text += "Click for use\n"
	for key in card.effects:
		labelEffects.text += key + ": " + str(card.effects[key]) + "\n"
	old_scale = self.scale
	self.scale = Vector2(0.8, 0.8)
	
func forge_animation(cardInitPos):
	initPos = cardInitPos
	animationPlayer.play("Intro")
	
func remove_card_from_forge():
	self.isStored = false

func _on_mouse_exited():
	mouseOn = false
	rectLabel.visible = false
	self.scale = old_scale

func _on_animation_player_animation_finished(anim_name):
	animationsFinished.append(anim_name)
	var tween = get_tree().create_tween()
	if initPos and anim_name == "Intro":
		tween.tween_property(self, "position", Vector2(initPos.x, initPos.y), 0.2).set_ease(Tween.EASE_OUT)
		tween.tween_callback(Global.player.gui.display_cards)
		tween.tween_callback(self.queue_free)
		

func _on_tween_completed():
	self.queue_free()
	
func destroy_card():
	var tween = get_tree().create_tween()
	tween.tween_property($Card, "scale", Vector2(0.1, 0.1), 0.3).set_ease(Tween.EASE_IN)
	animatesExplosions.visible = true
	animatesExplosions.play("vortex")


func _on_animates_explosions_animation_finished():
	animationsFinished.append(animatesExplosions.animation)
	#if animatesExplosions.animation == "vortex":
		#self.queue_free()
		
func _on_animates_explosions_frame_changed():
	if animatesExplosions.animation == "vortex" and animatesExplosions.frame == 14:
		$Card.visible = false


func use_card():
	self.card.applyEffects(Global.player)
	Global.player.remove_card(self.card)
	Global.player.gui.display_life(Global.player)
	self.queue_free()
