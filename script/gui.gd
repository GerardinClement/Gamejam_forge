class_name GUI

extends Control

@onready var fullHeart = preload("res://Assets/Interface/FullHeart.png")
@onready var halfHeart = preload("res://Assets/Interface/HalfHeart.png")
@onready var emptyHeart = preload("res://Assets/Interface/emptyHeart.png")

func display_life(player):
	remove_life()
	var textureRect = self.get_child(0)
	for i in player.pv_max:
		var textureDup = textureRect.duplicate()
		if i >= player.pv:
			textureDup.set_texture(emptyHeart)
		else:
			textureDup.set_texture(fullHeart)
		textureDup.position.x = (textureRect.position.x + textureRect.size.x) * i
		self.add_child(textureDup)

func remove_life():
	var childCount = self.get_child_count()
	for i in childCount:
		if i == 0:
			pass
		self.get_child(i).queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
