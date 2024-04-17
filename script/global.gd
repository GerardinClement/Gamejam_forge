extends Node

var playerPos = Vector2(0,0)
var player = null

#Array of ennemies
const ennemies = {
	"octopus": {
		"damage": 1,
		"speed": 20,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
	},
	"human": {
		"damage": 1,
		"speed": 20,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
	},
	"mech": {
		"damage": 1,
		"speed": 20,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
	},	
}
