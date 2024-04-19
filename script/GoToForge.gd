extends Area2D

@onready var markerPosition = $Marker2D.global_position
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if Global.playerIsInForge == false:
		Global.playerIsInForge = true
		Global.lastPosition = markerPosition
		get_tree().change_scene_to_file("res://forge.tscn")
	else:
		Global.playerIsInForge = false
		get_tree().change_scene_to_file("res://main.tscn")
