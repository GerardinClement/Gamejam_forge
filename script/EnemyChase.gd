extends State
class_name EnemyChase

@export var enemy: CharacterBody2D
var player: CharacterBody2D
var move_direction

#func chase_player(parent):
	#move_direction = Vector2()
	#enemy.ray.position = enemy.position
	#enemy.ray.target_position = parent.to_local(Global.playerPos)
	#enemy.ray.force_raycast_update()
#
	#if !enemy.ray.is_colliding():
		#move_direction = enemy.to_local(player.global_position)
	#elif Global.playerIsInForge:
		#for scent in Global.player.scent_trail:
			#enemy.ray.target_position = parent.to_local(scent.position)
			#enemy.ray.force_raycast_update()
			#if !enemy.ray.is_colliding():
				#move_direction = enemy.to_local(scent.position)
				#break

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
