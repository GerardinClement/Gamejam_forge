extends Node2D

var card
var onShop = false
var mouseOn = false
var isStored = false
var forChoose = false
var isSelected = false
var dropableZoneName

@onready var rectLabel = $ColorRect
@onready var labelName = $ColorRect/name
@onready var labelDescription = $ColorRect/description
@onready var labelEffects = $ColorRect/effects
@onready var animationPlayer = $Card/AnimationPlayer
@onready var animatesExplosions = $AnimatesExplosions
var initPos

func _ready():
	self.scale = Vector2(0.7, 0.7)
	rectLabel.visible = false
	self.input_pickable = true
	
func _process(delta):
	if Input.is_action_just_pressed("click") and onShop and mouseOn:
		get_parent().add_to_dropable(self)
	if Input.is_action_just_pressed("click") and forChoose and mouseOn:
		isSelected = true

func _on_mouse_entered():
	mouseOn = true
	if get_parent().name == "Black-smithShop":
		onShop = true
	rectLabel.visible = true
	labelName.text = card.name
	labelDescription.text = card.description
	labelEffects.text = ""
	for key in card.effects:
		labelEffects.text += key + ": " + str(card.effects[key]) + "\n"
	self.scale = Vector2(0.8, 0.8)
	
func forge_animation(cardInitPos):
	initPos = cardInitPos
	animationPlayer.play("Intro")
	
func remove_card_from_forge():
	self.isStored = false

func _on_mouse_exited():
	mouseOn = false
	rectLabel.visible = false
	self.scale = Vector2(0.7, 0.7)

func _on_animation_player_animation_finished(anim_name):
	var tween = get_tree().create_tween()
	if initPos:
		tween.tween_property(self, "position", Vector2(initPos.x, initPos.y), 0.2).set_ease(Tween.EASE_OUT)

func destroy_card():
	var tween = get_tree().create_tween()
	tween.tween_property($Card, "scale", Vector2(0.1, 0.1), 0.3).set_ease(Tween.EASE_IN)
	animatesExplosions.visible = true
	animatesExplosions.play("vortex")


func _on_animates_explosions_animation_finished():
	if animatesExplosions.animation == "vortex":
		self.queue_free()
		
func _on_animates_explosions_frame_changed():
	if animatesExplosions.animation == "vortex" and animatesExplosions.frame == 14:
		$Card.visible = false
