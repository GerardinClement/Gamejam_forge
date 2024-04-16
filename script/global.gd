extends Node

var playerPos = Vector2(0,0)

#Array of ennemies
const ennemies = {
	"octopus": {
		"damage": 10,
		"speed": 20,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
	},
	"human": {
		"damage": 10,
		"speed": 20,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
	},
	"mech": {
		"damage": 10,
		"speed": 20,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
	},	
}
