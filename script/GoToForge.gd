extends Area2D

@onready var markerPosition = $Marker2D.global_position

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name != "Player":
		return
	if Global.playerIsInForge == false:
		body.get_node("Music").stop()
		body.get_node("ForgeMusic").play()
		go_to_forge()
	else:
		body.get_node("ForgeMusic").stop()
		body.get_node("Music").play()
		exit_forge()
		
func go_to_forge():
	Global.playerIsInForge = true
	Global.lastPosition = markerPosition
	get_tree().change_scene_to_file("res://forge.tscn")

func exit_forge():
	Global.playerIsInForge = false
	get_tree().change_scene_to_file("res://main.tscn")
	
