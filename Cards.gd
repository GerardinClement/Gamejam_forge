var firstOne = Card.new("FirstOne", "This is the First one", {"increase_strenght": 10,"increase_attack_speed": 10, "increase_health": 10 }, null)
var heal = Card.new("Health +", "Give heal", {"increase_strenght": 0,"increase_attack_speed": 0, "increase_health": 20 }, null)
var cards = {
	"firstOne": firstOne,
	"heal+": heal
}

class Card:
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
					
func generate_random_card():
	var size = cards.size()
	var random_key = cards.keys()[randi() % size]
	return cards[random_key]
