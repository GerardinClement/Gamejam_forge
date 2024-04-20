extends Node

var gameIsStart = false
var playerPos = Vector2(0,0)
var lastPosition = Vector2(0, 0)
var allCards = null
var player = null
var pause = false
var playerIsDead = false
var playerIsInForge = false

#Array of ennemies
const ennemies = {
	"octopus": {
		"health": 50,
		"damage": 0.5,
		"speed": 50,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
	},
	"human": {
		"health": 500,
		"damage": 0.5,
		"speed": 50,
		"shootFrame": 1,
		"bulletSpeed": 200.0,
	},
	"mech": {
		"health": 100,
		"damage": 0.5,
		"speed": 50,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
	},	
}
