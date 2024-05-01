extends State
class_name EnemyChase

@export var enemy: CharacterBody2D
var player: CharacterBody2D
var move_direction

func enter():
	player = get_tree().get_first_node_in_group("Player")
	
func exit():
	pass
	
func update(_delta):
	pass

func physics_update(_delta):
	var direction = player.global_position - enemy.global_position
	if enemy.player_in:
		enemy.velocity = direction.normalized() * enemy.stats.speed
		if direction < Vector2(50, 50):
			enemy.velocity *= -1
	else:
		Transitioned.emit(self, "Idle")
