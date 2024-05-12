extends Camera2D


func _on_area_2d_body_entered(body):
	var groups = body.get_groups()
	if groups.has("enemy") or groups.has("Collectibles"):
		body.set_process(true)
		body.visible = true

func _on_area_2d_body_exited(body):
	var groups = body.get_groups()
	if body.get_groups().has("enemy") or groups.has("Collectibles"):
		set_process(false)
		body.visible = false
