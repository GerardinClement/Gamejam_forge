extends Node2D

@onready var sprite = $StaticBody2D/Sprite2D

class Card:
	var name: String
	var type: String
	var description: String
	var effects : Dictionary
	var image: ImageTexture

	func _init(name: String, description: String, type: String, effects: Dictionary):
		self.name = name
		self.description = description
		self.effects = effects
		self.type = type
		self.image = self.loadImage(self.name)

	func applyEffects(player):
		for effect_key in effects.keys():
			match effect_key:
				"strength":
					player.strength += effects[effect_key]
				"attack_speed":
					player.attack_speed += effects[effect_key]
				"pv_max":
					player.pv_max += effects[effect_key]
				"shootSide":
					addShootSide(player, effects[effect_key])

	func addShootSide(player, shootSide):
		pass
			
	func loadImage(name: String):
		var image_texture = ImageTexture.new()
		var new_image = Image.new()
		var error = new_image.load("res://Assets/Cards/" + name + ".png")
		
		if error == OK:
			print(name, " is loaded")
			return(image_texture.create_from_image(new_image))
		else:
			print(name + "Error: ", error)
	


func _on_sprite_2d_texture_changed():
	print("texture changed")
	print(sprite.get_texture())
	
