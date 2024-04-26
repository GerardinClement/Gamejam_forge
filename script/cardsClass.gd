extends Node2D

class Card:
	var name: String
	var type: String
	var level: int
	var description: String
	var effects : Dictionary
	var image: ImageTexture

	func _init(new_name: String, new_description: String, new_type: String, new_effects: Dictionary):
		self.name = new_name
		self.description = new_description
		self.effects = new_effects
		self.type = new_type
		self.level = 1
		
	func applyEffects(player):
		for effect_key in effects.keys():
			match effect_key:
				"strength":
					player.strength += effects[effect_key]
				"attack_speed":
					player.attack_speed -= player.attack_speed * effects[effect_key]
					if player.attack_speed <= 0:
						player.attack_speed = 0.1
				"pv_max":
					player.pv_max += effects[effect_key]
					player.pv += effects[effect_key]
				"speed":
					player.speed += effects[effect_key]
				"shootSide":
					addShootSide(player, effects[effect_key])

	func addShootSide(player, shootSide):
		for side in shootSide:
			player.shootSide[side] = true
			
	func removeEffects(player):
		for effect_key in effects.keys():
			match effect_key:
				"strength":
					player.strength -= effects[effect_key]
				"attack_speed":
					player.attack_speed += player.attack_speed * effects[effect_key]
					if player.attack_speed <= 0:
						player.attack_speed = 0.1
				"pv_max":
					player.pv_max -= effects[effect_key]
					player.pv -= effects[effect_key]
				"speed":
					player.speed -= effects[effect_key]
				"shootSide":
					addShootSide(player, effects[effect_key])

	func removeShootSide(player, shootSide):
		for side in shootSide:
			player.shootSide[side] = false
			
	func loadImage():
		var filename = self.name

		if self.type == "merge":
			filename = "mergeCard"
		var loadedTexture = load("res://Assets/Cards/" +  filename + ".png")
		return loadedTexture
