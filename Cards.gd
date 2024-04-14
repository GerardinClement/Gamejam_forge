extends Node2D



class Card:
	var name: String
	var description: String
	var effects : Dictionary
	var image: ImageTexture
	
	func _init(name: String, description: String, effects: Dictionary):
		self.name = name
		self.description = description
		self.effects = effects
		self.image = self.loadImage(self.name)

	func applyEffects(player):
		for effect_key in effects.keys():
			match effect_key in effects.keys():
				"increase_strenght":
					player.strength += effects[effect_key]
				"increase_attack_speed":
					player.attack_speed += effects[effect_key]
				"increase_health":
					player.health += effects[effect_key]
					
	func loadImage(name: String):
		var image_texture = ImageTexture.new()
		var image = Image.new()
		var error = image.load("res://Assets/Cards/" + name + ".png")
		
		if error == OK:
			image_texture.create_from_image(image)
			print(name, "is loaded")
		else:
			print(name + "Error: ", error)
	
