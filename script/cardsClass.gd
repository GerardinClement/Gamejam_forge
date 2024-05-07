extends Node2D

class Card:
	var name: String
	var type: String
	var level: int
	var description: String
	var effects : Dictionary
	var is_merge: bool
	var image: ImageTexture
	var animation: String

	func _init(new_name: String, new_description: String, new_type: String, new_effects: Dictionary):
		self.name = new_name
		self.description = new_description
		self.effects = new_effects
		self.type = new_type
		self.level = 1
		self.is_merge = false
		self.animation = ""
	
	func find_effect(player, key, value):
		match key:
			"strength":
				player.strength += value
			"attack_speed":
				player.attack_speed -= player.attack_speed * value
				if player.attack_speed <= 0:
					player.attack_speed = 0.1
			"pv_max":
				player.pv_max += value
				player.pv += value
			"pv":
				player.pv += value
			"speed":
				player.speed += value
			"n_bullet":
				player.n_bullet += value
			"shield":
				player.shield += value
			"money":
				player.money += value
			"empty":
				apply_special_effect(player)
				
	func apply_special_effect(player):
		var cardManager = CardManager.new()
		if self.name == "The Star":
			cardManager.theStarEffect(player)
		if self.name == "One Way Trip":
			cardManager.oneWayTripEffect(player)
			
	func applyEffects(player):
		for effect_key in effects.keys():
			find_effect(player, effect_key, effects[effect_key])
			if effect_key.contains("random"):
				generate_random(player, effect_key)
	
	func increase_level():
		for key in self.effects:
			find_effect(Global.player, key, self.effects[key])
			self.effects[key] += self.effects[key]
		self.level += 1
		self.animation = "increase_level"
	
	func generate_random(player, effect_key):
		var stat = effect_key.split("_")[1]
		var random = randi() % effects[effect_key] + 1
		find_effect(player, stat, random)
		
		
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
					if player.pv > player.pv_max:
						player.pv = player.pv_max
				"speed":
					player.speed -= effects[effect_key]
				"n_bullet":
					player.n_bullet -= effects[effect_key]
				"shield":
					player.shield -= effects[effect_key]

	func removeShootSide(player, shootSide):
		for side in shootSide:
			player.shootSide[side] = false
			
	func loadImage():
		var filename = self.name.replace(" ", "")

		if self.is_merge:
			filename = "mergeCard"
		var loadedTexture = load("res://Assets/Cards/" +  filename + ".png")
		return loadedTexture
