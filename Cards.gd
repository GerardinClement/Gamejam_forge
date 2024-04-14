extends Node

class Cards:
	var name: String
	var description: String
	var effects : Dictionary
	var image: Image
	
	func _init(name: String, description: String, effects: Dictionary, image: Image):
		self.name = name
		self.description = description
		self.effects = effects
		self.image = image

	func applyEffects(player):
		for effect_key in effects.keys():
			match effect_key in effects.keys():
				"increase_strenght":
					player.strength += effects[effect_key]
				"increase_attack_speed":
					player.attack_speed += effects[effect_key]
				"increase_health":
					player.health += effects[effect_key]
				
	
