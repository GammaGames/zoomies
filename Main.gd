extends Spatial

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		$Player.add_link()
