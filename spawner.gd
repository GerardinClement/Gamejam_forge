extends Area2D

func _on_body_entered(body):
	if body.name == "Player" and $Timer.is_stopped():
		spawn_enemies()

func spawn_enemies():
	var spawnerZone = self.find_child("SpawnZone")
	for i in 10:
		var size = Global.enemies_scene.size()
		var random_key = Global.enemies_scene.keys()[randi() % size]
		create_enemy_instance(random_key, spawnerZone)
		
func create_enemy_instance(enemy_name, spawnerZone):
	var enemy = Global.enemies_scene[enemy_name]
	var enemyInstance = enemy.instantiate()
	enemyInstance.enemy_name = enemy_name
	enemyInstance.global_position = get_spawn_position(spawnerZone)
	self.add_child(enemyInstance)
	
func get_spawn_position(spawnerZone):
	var rng = RandomNumberGenerator.new()
	var randomPos = Vector2(0, 0)
	var collision_shape = spawnerZone.get_child(0)
	var centerpos = collision_shape.position + spawnerZone.position
	var size = collision_shape.shape.extents

	randomPos.x = (randi() % int(size.x)) - (size.x/2) + centerpos.x
	randomPos.y = (randi() % int(size.y)) - (size.y/2) + centerpos.y
	return randomPos

