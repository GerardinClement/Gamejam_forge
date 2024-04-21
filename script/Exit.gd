extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$NotEnoughKeys.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if Global.playerKeys == Global.allKeys:
		get_tree().change_scene_to_file("res://Victory.tscn")
	else:
		$NotEnoughKeys.visible = true

func _on_body_exited(body):
	$NotEnoughKeys.visible = false
