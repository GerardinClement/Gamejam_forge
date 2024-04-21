extends Node

var gameIsStart = false
var playerPos = Vector2(0,0)
var lastPosition = Vector2(0, 0)
var allCards = null
var player = null
var pause = false
var playerIsDead = false
var playerIsInForge = false
var playerKeys = 0
var allKeys = 4
var deathAnimationOver = false
var deathSoundOver = false
var playerMoney = 0

#Array of ennemies
const ennemies = {
	"octopus": {
		"health": 50,
		"damage": 0.5,
		"speed": 50,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
		"goldAmount": "threeGolds",
		"goldValue": 3
	},
	"human": {
		"health": 25,
		"damage": 0.5,
		"speed": 50,
		"shootFrame": 1,
		"bulletSpeed": 200.0,
		"goldAmount": "oneGold",
		"goldValue": 1
	},
	"mech": {
		"health": 100,
		"damage": 0.5,
		"speed": 50,
		"shootFrame": 3,
		"bulletSpeed": 200.0,
		"goldAmount": "tenGolds",
		"goldValue": 10
	},	
}
