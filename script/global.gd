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
		"shootFrame": 4,
		"bulletSpeed": 200.0,
		"goldAmount": "tenGolds",
		"goldValue": 10
	},
	#"boss": {
		#"health": 250,
		#"damage": 2,
		#"speed": 25,
		#"shootFrame": 3,
		#"bulletSpeed": 300.0,
		#"goldAmount": "tenGolds",
		#"goldValue": 10
	#}
}

var enemies_scene = {
	"octopus": preload("res://AnimatedCharacters/Enemies/octopus/octopus.tscn"),
	"human": preload("res://AnimatedCharacters/Enemies/human/human.tscn"),
	"mech": preload("res://AnimatedCharacters/Enemies/mech/mech.tscn")
}
