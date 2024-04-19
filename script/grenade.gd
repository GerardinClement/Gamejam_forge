extends RigidBody2D

var throw_force = 500  # Force de lancement
var target_position = Vector2(100, 100)  # Position cible où vous voulez que la grenade arrive

func _ready():
	# Calculez le vecteur de déplacement
	var displacement_vector = target_position - global_position

	apply_impulse(Vector2(displacement_vector.x * throw_force, displacement_vector.y * throw_force), Vector2())

